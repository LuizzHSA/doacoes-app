# Doar App

Aplicativo Flutter de doações para campanhas solidárias: explore campanhas, veja detalhes, acompanhe o progresso e confirme doações.

## Tecnologias

**Front-end**

- **Flutter** (Dart ^3.13) — aplicativo mobile
- **flutter_riverpod** — gerenciamento de estado
- **go_router** — navegação e rotas nomeadas
- **Material Design** — componentes visuais

**Back-end**

- Python, FastAPI e Firebase Admin SDK
- A API fornece campanhas e doações de itens disponíveis para o Flutter

**Banco de dados**

- **Cloud Firestore** — coleções `campaigns` e `donations`
- A chave Firebase Admin fica somente no backend; nunca a inclua no aplicativo

## Rotas

| Rota                        | Tela                  |
| --------------------------- | --------------------- |
| `/home`                     | Home (inicial)        |
| `/explore`                  | Explorar campanhas    |
| `/profile`                  | Perfil                |
| `/campaign/:id`             | Detalhes da campanha  |
| `/campaign/:id/confirmacao` | Confirmação de doação |
| `/login`                    | Login                 |

Home, Explore e Perfil ficam dentro de um shell com navegação inferior (`StatefulShellRoute`).

## Como rodar

### API

Configure uma credencial de serviço Firebase nova (a chave compartilhada anteriormente deve ser revogada) e mantenha o arquivo fora do Git. No shell:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r database/requirements.txt
export FIREBASE_SERVICE_ACCOUNT_PATH="$PWD/database/serviceAccountKey.json"
uvicorn database.main:app --reload --host 0.0.0.0 --port 8000
```

A API disponibiliza estas rotas:

| Método | Rota | Acesso |
| --- | --- | --- |
| `GET` | `/api/campaigns` | Público |
| `GET` | `/api/communities?cidade=Curitiba&causa=Educação` | Público; filtros opcionais |
| `GET` | `/api/communities/{community_id}` | Público |
| `GET` | `/api/donations` | Público; somente itens disponíveis |
| `GET` | `/api/donations/{donation_id}` | Público |
| `POST` | `/api/donations` | Requer token Firebase Auth |
| `POST` | `/api/donations/{donation_id}/requests` | Requer token Firebase Auth |

Os `POST` recebem `Authorization: Bearer <Firebase ID token>`. Para publicar um item, envie JSON com `titulo` e `descricao`; `local_retirada` e `foto_url` são opcionais. Para solicitar uma doação, faça `POST` sem corpo. A reserva e a criação do match são gravadas na mesma transação. O app Flutter precisa autenticar no Firebase Auth para obter esse token.

Os documentos da coleção `communities` devem ter `name`, `description`, `city`, `state`, `neighborhood`, `address`, `causes` (lista), `latitude`, `longitude` e `verified`. A API só consulta comunidades; cadastre os documentos pelo console do Firestore ou por uma ferramenta administrativa confiável.

Para inserir as três campanhas iniciais no Firestore, execute uma vez, em outro terminal com o mesmo ambiente:

```bash
python -m database.seed_campaigns
```

### Flutter

Com a API rodando, execute:

```bash
flutter pub get
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000
```

O endereço `10.0.2.2` é o host visto pelo emulador Android. Para Flutter web, use `http://localhost:8000`; em um dispositivo físico, use o IP do computador na rede local. O manifesto Android permite HTTP somente na configuração debug. Em produção, publique a API com HTTPS e defina `API_BASE_URL` para o endereço HTTPS.

## Observações

- As telas Início, Explorar e Detalhes carregam campanhas pela API. Explorar também lista doações de itens com status `disponivel`.
- A API é somente leitura para o aplicativo; as funções administrativas de escrita permanecem no Python.
- Restrinja `API_CORS_ORIGINS` ao domínio do app ao publicar a API.
- Mockups de UI em `docs/ui_screen/`.
