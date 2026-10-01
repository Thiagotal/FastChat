// ============================================================================
// main.dart
// Ponto de entrada do aplicativo Flutter.
// Aqui a gente inicializa o Flutter, carrega as variáveis de ambiente (.env)
// e sobe o app chamando a tela de Login como primeira tela.
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

// Função main: é a primeira coisa que roda quando o app é aberto.
// É "async" porque precisamos esperar o carregamento do arquivo .env
// (que guarda, por exemplo, a chave da API do Gemini) antes de iniciar o app.
Future<void> main() async {
  // Garante que os "bindings" do Flutter estejam prontos antes de rodar
  // qualquer código assíncrono (obrigatório quando usamos "await" antes do runApp).
  WidgetsFlutterBinding.ensureInitialized();

  // Carrega as variáveis do arquivo .env (ex: GEMINI_API_KEY) para dentro do app.
  // Esse arquivo NÃO deve ser enviado para o Git (ver .gitignore) por segurança.
  await dotenv.load(fileName: '.env');

  // Inicia o app Flutter, renderizando o widget MyApp na tela.
  runApp(const MyApp());
}

// Widget raiz do aplicativo. Todo app Flutter começa com um widget principal
// (geralmente um MaterialApp) que configura tema, título e a tela inicial.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Corporativo',
      // Remove a faixa "DEBUG" que aparece no canto superior direito durante o desenvolvimento.
      debugShowCheckedModeBanner: false,
      // Aplica o tema visual (cores, fontes, estilos de botão etc.) definido em app_theme.dart.
      theme: AppTheme.tema,
      // Primeira tela exibida ao abrir o app: a tela de login.
      home: const LoginScreen(),
    );
  }
}
