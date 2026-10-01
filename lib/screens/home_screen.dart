// ============================================================================
// home_screen.dart
// Tela principal do app, exibida logo após o login. Contém uma barra de
// navegação inferior (NavigationBar) que alterna entre a tela de Setores
// e a tela do Chatbot, sem precisar empilhar novas telas na pilha de navegação.
// ============================================================================

import 'package:flutter/material.dart';
import 'setores_screen.dart';
import 'chatbot_screen.dart';

// StatefulWidget porque precisamos guardar qual aba está selecionada no momento.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Índice da aba atualmente selecionada (0 = Setores, 1 = Chatbot).
  int _indiceAtual = 0;

  // Lista fixa com as telas de cada aba. A ordem aqui deve bater com a
  // ordem dos itens em "destinations" logo abaixo.
  final _telas = const [
    SetoresScreen(),
    ChatbotScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Mostra a tela correspondente ao índice selecionado.
      body: _telas[_indiceAtual],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indiceAtual,
        // Quando o usuário toca em um item da barra, atualiza o índice
        // e o Flutter redesenha a tela automaticamente (setState).
        onDestinationSelected: (i) => setState(() => _indiceAtual = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.business), label: 'Setores'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Chatbot'),
        ],
      ),
    );
  }
}
