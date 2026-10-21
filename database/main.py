
import os

import firebase_admin
from firebase_admin import credentials, firestore
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

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
    allow_methods=["GET"],
    allow_headers=["*"],
)

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


def criar_doacao(titulo, descricao, user_id):
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


def _document_data(document):
    data = document.to_dict() or {}
    data['id'] = document.id
    return data


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
    fields = ('titulo', 'descricao', 'status')
    return [
        {
            'id': doc.id,
            **{field: (doc.to_dict() or {}).get(field) for field in fields},
        }
        for doc in donations
    ]


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