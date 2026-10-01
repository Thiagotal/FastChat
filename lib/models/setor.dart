// ============================================================================
// setor.dart
// Modelo que representa um setor/departamento da empresa (ex: TI, Financeiro).
// Cada setor tem um nome e uma lista de colaboradores que trabalham nele.
// ============================================================================

import 'colaborador.dart';

class Setor {
  final String nome;
  // Lista de colaboradores que pertencem a este setor.
  final List<Colaborador> colaboradores;

  const Setor({
    required this.nome,
    required this.colaboradores,
  });
}
