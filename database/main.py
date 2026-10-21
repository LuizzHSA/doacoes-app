
import os

import firebase_admin
from firebase_admin import auth, credentials, exceptions, firestore
from fastapi import Depends, FastAPI, HTTPException, Query
from fastapi.middleware.cors import CORSMiddleware
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from pydantic import BaseModel, Field

credential_path = os.getenv("FIREBASE_SERVICE_ACCOUNT_PATH")
cred = (
    credentials.Certificate(credential_path)
    if credential_path
    else credentials.ApplicationDefault()
)

firebase_admin.initialize_app(cred)

db = firestore.client()   
app = FastAPI(title="Doacoes API")
app.add_middleware(
    CORSMiddleware,
    allow_origins=os.getenv("API_CORS_ORIGINS", "*").split(","),
    allow_methods=["GET", "POST"],
    allow_headers=["*"],
)
bearer_scheme = HTTPBearer(auto_error=False)


class DonationCreate(BaseModel):
    titulo: str = Field(min_length=2, max_length=120)
    descricao: str = Field(min_length=2, max_length=2000)
    local_retirada: str | None = Field(default=None, max_length=200)
    foto_url: str | None = Field(default=None, max_length=2048)


def usuario_autenticado(
    credentials: HTTPAuthorizationCredentials | None = Depends(bearer_scheme),
):
    if credentials is None:
        raise HTTPException(status_code=401, detail="Autenticação necessária.")
    try:
        token = auth.verify_id_token(credentials.credentials)
    except (ValueError, exceptions.FirebaseError) as exc:
        raise HTTPException(status_code=401, detail="Token inválido.") from exc
    return token["uid"]

# Funções

def criar_usuario(nome, email, telefone, tipo, foto_url=None):
    user_ref = db.collection('users').document()
    data = {
        'id': user_ref.id,
        'nome': nome,
        'email': email,
        'telefone': telefone,
        'tipo': tipo,
        'foto_url': foto_url,
        'created_at': firestore.SERVER_TIMESTAMP,
        'updated_at': firestore.SERVER_TIMESTAMP
    }
    user_ref.set(data)
    print(f"Usuario criado -> {nome} (ID: {user_ref.id})")
    return user_ref.id


def criar_doacao(titulo, descricao, user_id, local_retirada=None, foto_url=None):
    doc_ref = db.collection('donations').document()
    data = {
        'id': doc_ref.id,
        'titulo': titulo,
        'descricao': descricao,
        'status': 'disponivel',
        'user_id': user_id,
        'created_at': firestore.SERVER_TIMESTAMP,
        'updated_at': firestore.SERVER_TIMESTAMP
    }
    if local_retirada:
        data['local_retirada'] = local_retirada
    if foto_url:
        data['foto_url'] = foto_url
    doc_ref.set(data)
    print(f"Doacao criada -> {titulo}")
    return doc_ref.id


def criar_campanha(
    titulo, categoria, descricao, arrecadado, meta, apoiadores=0, campanha_id=None
):
    campaigns = db.collection('campaigns')
    doc_ref = campaigns.document(campanha_id) if campanha_id else campaigns.document()
    data = {
        'id': doc_ref.id,
        'title': titulo,
        'category': categoria,
        'description': descricao,
        'raised': arrecadado,
        'goal': meta,
        'supporters': apoiadores,
        'created_at': firestore.SERVER_TIMESTAMP,
        'updated_at': firestore.SERVER_TIMESTAMP
    }
    doc_ref.set(data)
    print(f"Campanha criada -> {titulo}")
    return doc_ref.id


def _community_data(document):
    data = document.to_dict() or {}
    fields = (
        'name', 'description', 'city', 'state', 'neighborhood', 'address',
        'causes', 'latitude', 'longitude', 'verified'
    )
    return {'id': document.id, **{field: data.get(field) for field in fields}}


def _donation_data(document):
    data = document.to_dict() or {}
    fields = ('titulo', 'descricao', 'status', 'local_retirada', 'foto_url')
    return {'id': document.id, **{field: data.get(field) for field in fields}}


@app.get('/api/communities')
def listar_comunidades(
    cidade: str | None = Query(default=None, min_length=2, max_length=100),
    causa: str | None = Query(default=None, min_length=2, max_length=80),
    limit: int = Query(default=50, ge=1, le=100),
):
    communities = db.collection('communities')
    if cidade:
        communities = communities.where('city', '==', cidade.strip())
    elif causa:
        communities = communities.where('causes', 'array_contains', causa.strip())
    results = []
    for document in communities.stream():
        data = document.to_dict() or {}
        if causa and causa.strip() not in data.get('causes', []):
            continue
        results.append(_community_data(document))
        if len(results) == limit:
            break
    return results


@app.get('/api/communities/{community_id}')
def obter_comunidade(community_id: str):
    document = db.collection('communities').document(community_id).get()
    if not document.exists:
        raise HTTPException(status_code=404, detail="Comunidade não encontrada.")
    return _community_data(document)


@app.get('/api/campaigns')
def listar_campanhas():
    fields = ('title', 'category', 'description', 'raised', 'goal', 'supporters')
    return [
        {
            'id': doc.id,
            **{field: (doc.to_dict() or {}).get(field) for field in fields},
        }
        for doc in db.collection('campaigns').stream()
    ]


@app.get('/api/donations')
def listar_doacoes():
    donations = db.collection('donations').where(
        'status', '==', 'disponivel'
    ).stream()
    return [_donation_data(doc) for doc in donations]


@app.post('/api/donations', status_code=201)
def publicar_doacao(
    donation: DonationCreate,
    user_id: str = Depends(usuario_autenticado),
):
    donation_id = criar_doacao(
        donation.titulo,
        donation.descricao,
        user_id,
        donation.local_retirada,
        donation.foto_url,
    )
    return {
        'id': donation_id,
        'titulo': donation.titulo,
        'descricao': donation.descricao,
        'status': 'disponivel',
        'local_retirada': donation.local_retirada,
        'foto_url': donation.foto_url,
    }


@app.get('/api/donations/{donation_id}')
def obter_doacao(donation_id: str):
    document = db.collection('donations').document(donation_id).get()
    if not document.exists:
        raise HTTPException(status_code=404, detail="Doação não encontrada.")
    return _donation_data(document)


@app.post('/api/donations/{donation_id}/requests', status_code=201)
def solicitar_doacao(
    donation_id: str,
    receiver_id: str = Depends(usuario_autenticado),
):
    donation_ref = db.collection('donations').document(donation_id)
    transaction = db.transaction()

    @firestore.transactional
    def create_request(transaction):
        donation = donation_ref.get(transaction=transaction)
        if not donation.exists:
            raise HTTPException(status_code=404, detail="Doação não encontrada.")
        donation_data = donation.to_dict() or {}
        if donation_data.get('user_id') == receiver_id:
            raise HTTPException(
                status_code=409,
                detail="Você não pode solicitar sua própria doação.",
            )
        if donation_data.get('status') != 'disponivel':
            raise HTTPException(status_code=409, detail="Doação indisponível.")

        match_ref = db.collection('matches').document()
        transaction.update(donation_ref, {
            'status': 'reservado',
            'updated_at': firestore.SERVER_TIMESTAMP,
        })
        transaction.set(match_ref, {
            'id': match_ref.id,
            'donation_id': donation_id,
            'donor_id': donation_data.get('user_id'),
            'receiver_id': receiver_id,
            'status': 'solicitado',
            'created_at': firestore.SERVER_TIMESTAMP,
        })
        return match_ref.id

    match_id = create_request(transaction)
    return {'match_id': match_id, 'status': 'solicitado'}


def criar_match(donation_id, donor_id, receiver_id):
    doc_ref = db.collection('matches').document()
    data = {
        'id': doc_ref.id,
        'donation_id': donation_id,
        'donor_id': donor_id,
        'receiver_id': receiver_id,
        'status': 'ativo',
        'created_at': firestore.SERVER_TIMESTAMP
    }
    doc_ref.set(data)
    print("Match criado")
    return doc_ref.id


def enviar_mensagem(match_id, sender_id, mensagem):
    doc_ref = db.collection('matches').document(match_id).collection('messages').document()
    data = {
        'id': doc_ref.id,
        'sender_id': sender_id,
        'mensagem': mensagem,
        'created_at': firestore.SERVER_TIMESTAMP
    }
    doc_ref.set(data)
    print("Mensagem enviada")
    return doc_ref.id


# Parte para testes -> retirar ou comentar se não precisar usar mais 
if __name__ == "__main__":
    print("Iniciando teste...\n")
    
    donor = criar_usuario("João Silva", "joao@email.com", "44999999999", "doador")
    receiver = criar_usuario("Maria Oliveira", "maria@email.com", "44988888888", "receptor")
    
    doacao = criar_doacao("Geladeira Boa", "Geladeira semi nova", donor)
    
    match = criar_match(doacao, donor, receiver)
    
    enviar_mensagem(match, donor, "Oi, posso buscar amanhã?")
    
    print("\nTeste finalizado com sucesso!")