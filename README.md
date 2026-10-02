// App Corporativo (Projeto Integrado)

RA:25002087 NOME:Gabriel Barbosa Corrêa

RA:25000952 NOME: João Pedro Barreiro

RA:25000918 NOME:Leonardo Monteiro Benatti

RA:25001673 NOME:Thiago Antônio Luiz

Fluxo principal:

```
Login (senha)
  └── Home (abas: Setores | Chatbot)
        ├── Setores → Colaboradores do setor → Detalhe (ramal + função)
        └── Chatbot (integrado com a API do Gemini, restrito a rede/infraestrutura)
```

// Como rodar
1. Instale o Flutter SDK.
2. Renomeie/edite o arquivo `.env` na raiz do projeto e coloque sua chave:
   ```
   GEMINI_API_KEY=sua_chave_aqui
   ```
   (o `.env.example` mostra o formato esperado — o `.env` real **nunca** deve ser commitado, ele já está no `.gitignore`)
3. `flutter pub get`
4. `flutter run`

// Estrutura
- `lib/models/` — classes `Colaborador` e `Setor`
- `lib/data/mock_data.dart` — dados fixos de setores/colaboradores (placeholder)
- `lib/theme/app_theme.dart` — paleta de cores (azul/laranja) e tema do app
- `lib/widgets/mascote_avatar.dart` — avatar do mascote, usado na home e no chatbot
- `lib/services/gemini_service.dart` — integração com a API do Gemini
- `lib/screens/` — telas do app
- `lib/main.dart` — ponto de entrada (carrega o `.env` antes de subir o app)

//Sobre a integração com o Gemini
- Modelo usado: `gemini-2.5-flash` (via REST, endpoint `generateContent`).
- O prompt de sistema em `gemini_service.dart` restringe o chatbot a
  responder apenas sobre rede e infraestrutura — ajuste o texto se quiser
  mudar o escopo.
- Erros de rede/API são tratados e mostrados como mensagem do bot, sem
  derrubar o app.

//⚠️ Segurança da chave de API
A chave está em `.env`, carregada em tempo de execução, e o arquivo está
no `.gitignore` — **confirmem antes de dar `git push`** que o `.env` real
não aparece no `git status`. Para uma entrega em produção de verdade, o
ideal seria nem embutir a chave no app (que pode ser descompilado), e sim
chamar a API do Gemini a partir de um backend próprio — mas para o escopo
deste projeto, manter a chave fora do controle de versão já resolve o
principal risco (vazamento público no GitHub).


//O que ainda é placeholder
1. **Autenticação**: senha fixa (`1234`) no `login_screen.dart` — trocar
   por autenticação real (ex: Firebase Auth).
2. **Dados de setores/colaboradores**: hoje vêm de `mock_data.dart` —
   trocar por uma fonte real (Firestore, API própria, etc.).
