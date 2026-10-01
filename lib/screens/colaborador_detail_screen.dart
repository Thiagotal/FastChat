// ============================================================================
// colaborador_detail_screen.dart
// Tela final da navegação de setores: mostra os detalhes completos de um
// único colaborador (nome, função e ramal) dentro de um Card.
// ============================================================================

import 'package:flutter/material.dart';
import '../models/colaborador.dart';

class ColaboradorDetailScreen extends StatelessWidget {
  // Colaborador recebido da tela anterior (colaboradores_screen.dart).
  final Colaborador colaborador;

  const ColaboradorDetailScreen({super.key, required this.colaborador});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(colaborador.nome)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              // Alinha todo o conteúdo à esquerda dentro da coluna.
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cabeçalho com avatar genérico + nome do colaborador em destaque.
                Row(
                  children: [
                    const CircleAvatar(radius: 28, child: Icon(Icons.person, size: 28)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        colaborador.nome,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 32),
                // Linhas com as demais informações do colaborador, reutilizando
                // o widget auxiliar "_linhaInfo" definido abaixo.
                _linhaInfo(Icons.work_outline, 'Função', colaborador.funcao),
                const SizedBox(height: 12),
                _linhaInfo(Icons.phone_outlined, 'Ramal', colaborador.ramal),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget auxiliar (privado) que monta uma linha padrão de "ícone + rótulo:
  // valor". Evita repetir o mesmo código de layout para Função e Ramal.
  Widget _linhaInfo(IconData icone, String rotulo, String valor) {
    return Row(
      children: [
        Icon(icone, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 8),
        Text('$rotulo: ', style: const TextStyle(fontWeight: FontWeight.w600)),
        Text(valor),
      ],
    );
  }
}
