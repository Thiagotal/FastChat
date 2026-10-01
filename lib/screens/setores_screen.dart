// ============================================================================
// setores_screen.dart
// Tela que lista todos os setores da empresa (TI, Financeiro, RH...).
// Ao tocar em um setor, o usuário é levado para a lista de colaboradores
// daquele setor (colaboradores_screen.dart).
// ============================================================================

import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/mascote_avatar.dart';
import 'colaboradores_screen.dart';

// StatelessWidget: essa tela não precisa guardar nenhum estado próprio,
// ela só exibe a lista de setores vinda de mock_data.dart.
class SetoresScreen extends StatelessWidget {
  const SetoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setores')),
      body: Column(
        children: [
          // Cabeçalho de boas-vindas com o mascote do app e uma mensagem
          // orientando o usuário sobre o que fazer nessa tela.
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: AppColors.azulPrincipal.withOpacity(0.06),
            child: Row(
              children: [
                const MascoteAvatar(tamanho: 56),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Olá! Escolha um setor para ver os colaboradores.',
                    style: TextStyle(color: AppColors.azulEscuro, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          // Lista com todos os setores cadastrados em mockSetores.
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: mockSetores.length,
              // Desenha uma linha divisória fina entre cada item da lista.
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final setor = mockSetores[index];
                return ListTile(
                  leading: const Icon(Icons.folder_open),
                  title: Text(setor.nome),
                  // Mostra quantos colaboradores existem naquele setor.
                  subtitle: Text('${setor.colaboradores.length} colaborador(es)'),
                  trailing: const Icon(Icons.chevron_right),
                  // Ao tocar, navega para a tela de colaboradores daquele
                  // setor específico, passando o objeto "setor" como parâmetro.
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ColaboradoresScreen(setor: setor),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
