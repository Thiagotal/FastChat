// ============================================================================
// mascote_avatar.dart
// Widget reutilizável que exibe a imagem do mascote do app em formato
// circular. É usado tanto na tela de Setores quanto na tela do Chatbot,
// evitando repetir o mesmo código de imagem em vários lugares.
// ============================================================================

import 'package:flutter/material.dart';

/// Avatar do mascote do app, reutilizado na home e no chatbot.
class MascoteAvatar extends StatelessWidget {
  // Permite ajustar o tamanho do avatar conforme onde ele for usado
  // (ex: maior no cabeçalho de setores, menor dentro do chat).
  final double tamanho;

  const MascoteAvatar({super.key, this.tamanho = 40});

  @override
  Widget build(BuildContext context) {
    // ClipOval corta a imagem em formato de círculo (oval quando largura
    // e altura são diferentes, círculo perfeito quando são iguais).
    return ClipOval(
      child: Image.asset(
        'assets/images/mascote.png', // Imagem declarada no pubspec.yaml
        width: tamanho,
        height: tamanho,
        // BoxFit.cover garante que a imagem preencha todo o espaço
        // sem distorcer, cortando o excesso se necessário.
        fit: BoxFit.cover,
      ),
    );
  }
}
