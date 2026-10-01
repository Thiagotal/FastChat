import '../models/setor.dart';
import '../models/colaborador.dart';

/// Dados mockados apenas para o esqueleto do app.
/// Depois substituir por consulta a um backend (ex: Firestore, REST API).
final List<Setor> mockSetores = [
  Setor(
    nome: 'TI - Infraestrutura',
    colaboradores: const [
      Colaborador(nome: 'Carlos Almeida', funcao: 'Analista de Redes', ramal: '259'),
      Colaborador(nome: 'Fernanda Souza', funcao: 'Técnica de Suporte', ramal: '357'),
      Colaborador(nome: 'Rafael Lima', funcao: 'Coordenador de TI', ramal: '358'),
    ],
  ),
  Setor(
    nome: 'Financeiro',
    colaboradores: const [
      Colaborador(nome: 'Juliana Costa', funcao: 'Analista Financeiro', ramal: '210'),
      Colaborador(nome: 'Marcos Pereira', funcao: 'Gerente Financeiro', ramal: '211'),
    ],
  ),
  Setor(
    nome: 'Recursos Humanos',
    colaboradores: const [
      Colaborador(nome: 'Patrícia Rocha', funcao: 'Analista de RH', ramal: '150'),
      Colaborador(nome: 'André Martins', funcao: 'Gerente de RH', ramal: '151'),
    ],
  ),
];

/// Busca determinística (não usa IA): procura, nos dados internos, um
/// colaborador cujo nome (ou parte dele) apareça no texto da pergunta.
/// Usada para responder perguntas sobre ramais sem depender do modelo
/// generativo, evitando risco de alucinação em dado interno crítico.
Colaborador? buscarColaboradorNaPergunta(String pergunta) {
  final termo = _normalizar(pergunta);

  for (final setor in mockSetores) {
    for (final colaborador in setor.colaboradores) {
      final partesNome = _normalizar(colaborador.nome).split(' ');
      for (final parte in partesNome) {
        if (parte.length >= 3 && termo.contains(parte)) {
          return colaborador;
        }
      }
    }
  }
  return null;
}

String _normalizar(String texto) {
  const comAcento = 'áàâãäéèêëíìîïóòôõöúùûüç';
  const semAcento = 'aaaaaeeeeiiiiooooouuuuc';
  var resultado = texto.toLowerCase();
  for (var i = 0; i < comAcento.length; i++) {
    resultado = resultado.replaceAll(comAcento[i], semAcento[i]);
  }
  return resultado;
}
