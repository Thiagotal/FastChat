// ============================================================================
// colaborador.dart
// Modelo (classe de dados) que representa um colaborador da empresa.
// É usado para guardar as informações de nome, função e ramal de cada
// funcionário exibido nas telas de setores e detalhes.
// ============================================================================

class Colaborador {
  // "final" significa que, depois de criado o objeto, esses valores
  // não podem mais ser alterados (imutável).
  final String nome;
  final String funcao; // Cargo/função do colaborador (ex: "Analista de Redes")
  final String ramal;  // Ramal telefônico do colaborador

  // Construtor "const": permite criar objetos Colaborador em tempo de
  // compilação (mais performático), como é feito em mock_data.dart.
  // "required" obriga quem for criar um Colaborador a informar todos os campos.
  const Colaborador({
    required this.nome,
    required this.funcao,
    required this.ramal,
  });
}
