# Doar App

Aplicativo Flutter de doações para campanhas solidárias: explore campanhas, veja detalhes, acompanhe o progresso e confirme doações.

## Tecnologias

**Front-end**

- **Flutter** (Dart ^3.13) — aplicativo mobile
- **flutter_riverpod** — gerenciamento de estado
- **go_router** — navegação e rotas nomeadas
- **Material Design** — componentes visuais

**Back-end**

- Ainda não integrado — os dados são mockados no app

**Banco de dados**

- **Firebase** (planejado) — por enquanto os dados de campanhas ficam em `lib/shared/models/campaign.dart`

**API**

- Nenhuma consumida atualmente; quando o Firebase for integrado, a comunicação será feita pelos SDKs do Firebase`

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

```bash
flutter pub get
flutter run
```

## Observações

- Os dados das campanhas são mockados em `lib/shared/models/campaign.dart` — não há backend integrado ainda (a intenção é usar Firebase).
- Mockups de UI em `docs/ui_screen/`.
