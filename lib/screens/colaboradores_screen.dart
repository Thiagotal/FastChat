// ============================================================================
// colaboradores_screen.dart
// Tela que lista os colaboradores de um setor específico. Recebe o "Setor"
// escolhido na tela anterior (setores_screen.dart) como parâmetro.
// Ao tocar em um colaborador, abre a tela de detalhes dele.
// ============================================================================

import 'package:flutter/material.dart';
import '../models/setor.dart';
import 'colaborador_detail_screen.dart';

class ColaboradoresScreen extends StatelessWidget {
  // Setor recebido da tela anterior — contém a lista de colaboradores a exibir.
  final Setor setor;

  const ColaboradoresScreen({super.key, required this.setor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // O título da AppBar muda dinamicamente conforme o setor escolhido.
      appBar: AppBar(title: Text(setor.nome)),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: setor.colaboradores.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final colaborador = setor.colaboradores[index];
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(colaborador.nome),
            subtitle: Text(colaborador.funcao),
            trailing: const Icon(Icons.chevron_right),
            // Ao tocar em um colaborador, navega para a tela de detalhes,
            // passando o objeto "colaborador" selecionado.
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ColaboradorDetailScreen(colaborador: colaborador),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
