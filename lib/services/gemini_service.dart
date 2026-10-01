import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Serviço de integração com a API do Gemini (Google AI), usando o SDK
/// oficial (package:google_generative_ai) em vez de chamada REST crua.
/// A chave é lida do arquivo .env (NUNCA deve ser commitada no Git).
class GeminiService {
  static const _modelo = 'gemini-2.5-flash';

  static const _promptSistema =
      'Você é um assistente técnico especializado em redes e infraestrutura de TI, '
      'usado por técnicos de campo dentro de um aplicativo corporativo. '
      'Responda apenas perguntas sobre: conectividade, roteadores, IP, cabeamento, '
      'Wi-Fi, DNS, troubleshooting de rede e infraestrutura de TI em geral. '
      'Se a pergunta não for sobre esses temas, explique educadamente que você só '
      'pode ajudar com assuntos de rede e infraestrutura. '
      'Seja direto, técnico e objetivo, como em um manual de suporte de campo. '
      'Responda em texto simples, SEM markdown (sem **, #, listas numeradas com '
      'marcação especial) — use no máximo 2 ou 3 frases curtas, a não ser que a '
      'pergunta peça explicitamente uma lista de passos.';

  static GenerativeModel? _modelCache;

  static GenerativeModel _obterModel() {
    if (_modelCache != null) return _modelCache!;

    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Chave de API do Gemini não configurada (.env).');
    }

    _modelCache = GenerativeModel(
      model: _modelo,
      apiKey: apiKey,
      systemInstruction: Content.system(_promptSistema),
    );
    return _modelCache!;
  }

  /// Envia a pergunta do usuário e retorna a resposta em texto.
  /// Lança uma exceção com mensagem amigável em caso de erro.
  static Future<String> perguntar(String pergunta) async {
    final model = _obterModel();

    final resposta = await model
        .generateContent([Content.text(pergunta)])
        .timeout(const Duration(seconds: 45));

    final texto = resposta.text;
    if (texto == null || texto.trim().isEmpty) {
      throw Exception('Resposta vazia da API do Gemini.');
    }

    return texto.trim();
  }
}
