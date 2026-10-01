// ============================================================================
// login_screen.dart
// Tela de login do aplicativo. É a primeira tela exibida ao abrir o app
// (ver main.dart). Neste protótipo, a autenticação é feita com uma senha
// fixa apenas para fins de demonstração/apresentação.
// ============================================================================

import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../theme/app_theme.dart';

// StatefulWidget: usado porque essa tela precisa "lembrar" e atualizar
// informações que mudam com o tempo, como o texto digitado e a mensagem de erro.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controlador do campo de senha: permite ler/limpar o texto digitado.
  final _senhaController = TextEditingController();

  // Guarda a mensagem de erro (ex: "Senha incorreta") para exibir na tela.
  // Fica "null" quando não há erro.
  String? _erro;

  // Senha fixa apenas para o esqueleto.
  // Substituir por autenticação real (ex: Firebase Auth) antes da entrega final.
  static const _senhaValida = '1234';

  // Método chamado ao clicar em "ENTRAR" ou pressionar Enter no campo de senha.
  void _entrar() {
    if (_senhaController.text == _senhaValida) {
      // Senha correta: limpa qualquer erro e navega para a Home,
      // substituindo a tela de login (pushReplacement) para que o usuário
      // não consiga "voltar" para o login apertando o botão de voltar.
      setState(() => _erro = null);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      // Senha incorreta: atualiza o estado para mostrar a mensagem de erro
      // embaixo do campo de senha.
      setState(() => _erro = 'Senha incorreta');
    }
  }

  // dispose() é chamado automaticamente quando a tela é destruída.
  // Aqui liberamos o TextEditingController da memória para evitar vazamentos.
  @override
  void dispose() {
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Fundo com um degradê (gradiente) do azul escuro para o azul principal,
        // dando um efeito visual mais elegante que uma cor sólida.
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.azulEscuro, AppColors.azulPrincipal],
          ),
        ),
        child: Center(
          // SingleChildScrollView evita erros de "overflow" quando o teclado
          // abre em telas pequenas, permitindo rolar o conteúdo.
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            // Limita a largura máxima do card de login (fica melhor em telas largas/web).
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
                  child: Column(
                    // mainAxisSize.min faz a coluna ocupar só o espaço necessário,
                    // em vez de esticar até o fim da tela.
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _logo(),
                      const SizedBox(height: 28),
                      // Campo de usuário/e-mail (apenas visual neste protótipo,
                      // não é validado — só a senha é checada).
                      TextField(
                        decoration: const InputDecoration(labelText: 'E-mail / Usuário'),
                      ),
                      const SizedBox(height: 16),
                      // Campo de senha: obscureText esconde os caracteres digitados.
                      TextField(
                        controller: _senhaController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          errorText: _erro, // Exibe a mensagem de erro, se houver.
                        ),
                        onSubmitted: (_) => _entrar(), // Permite logar apertando Enter.
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity, // Botão ocupa toda a largura disponível.
                        child: ElevatedButton(
                          onPressed: _entrar,
                          child: const Text('ENTRAR'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget auxiliar que monta o logo do app: um ícone dentro de um
  // quadrado azul + o texto "App Corporativo" com cores diferentes
  // para cada parte (usando RichText/TextSpan).
  Widget _logo() {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.azulPrincipal,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.hub_outlined, color: AppColors.laranja, size: 34),
        ),
        const SizedBox(height: 12),
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
            children: [
              TextSpan(text: 'App ', style: TextStyle(color: AppColors.azulPrincipal)),
              TextSpan(text: 'Corporativo', style: TextStyle(color: AppColors.laranja)),
            ],
          ),
        ),
      ],
    );
  }
}
