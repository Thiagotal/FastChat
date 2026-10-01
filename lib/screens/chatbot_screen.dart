import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/mascote_avatar.dart';
import '../services/gemini_service.dart';
import '../data/mock_data.dart';

class _Mensagem {
  final String texto;
  final bool doUsuario;

  _Mensagem(this.texto, this.doUsuario);
}

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final List<_Mensagem> _mensagens = [
    _Mensagem(
      'Olá! Sou o assistente de rede e infraestrutura. Pergunte sobre '
      'problemas de conexão, IP, roteadores, etc. — ou pergunte o ramal '
      'de um colaborador pelo nome.',
      false,
    ),
  ];
  bool _carregando = false;

  Future<void> _enviar() async {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;

    setState(() {
      _mensagens.add(_Mensagem(texto, true));
      _carregando = true;
      _controller.clear();
    });
    _rolarParaFinal();

    String resposta;
    final colaborador = buscarColaboradorNaPergunta(texto);

    if (colaborador != null) {
      // Resposta determinística: veio dos dados internos, não da IA.
      resposta = '${colaborador.nome} é ${colaborador.funcao} '
          'e o ramal é ${colaborador.ramal}.';
    } else {
      try {
        resposta = await GeminiService.perguntar(texto);
      } catch (e) {
        resposta = 'Não consegui falar com o serviço de IA agora. '
            'Verifique sua conexão e tente novamente. (${e.toString()})';
      }
    }

    if (!mounted) return;
    setState(() {
      _mensagens.add(_Mensagem(resposta, false));
      _carregando = false;
    });
    _rolarParaFinal();
  }

  void _rolarParaFinal() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            MascoteAvatar(tamanho: 32),
            SizedBox(width: 10),
            Text('Chatbot - Rede & Infraestrutura'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: _mensagens.length,
              itemBuilder: (context, index) => _bolhaMensagem(_mensagens[index]),
            ),
          ),
          if (_carregando)
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text('Digitando...', style: TextStyle(color: Colors.grey)),
            ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Digite sua dúvida sobre rede...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    onSubmitted: (_) => _enviar(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _carregando ? null : _enviar,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bolhaMensagem(_Mensagem mensagem) {
    final alinhamento = mensagem.doUsuario ? Alignment.centerRight : Alignment.centerLeft;
    final cor = mensagem.doUsuario
        ? AppColors.laranja.withOpacity(0.15)
        : AppColors.azulPrincipal.withOpacity(0.08);
    final corTexto = mensagem.doUsuario ? AppColors.laranjaEscuro : AppColors.azulEscuro;
    final raio = mensagem.doUsuario
        ? const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    final bolha = Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.68),
      decoration: BoxDecoration(color: cor, borderRadius: raio),
      child: Text(mensagem.texto, style: TextStyle(color: corTexto)),
    );

    if (mensagem.doUsuario) {
      return Align(alignment: alinhamento, child: bolha);
    }

    return Align(
      alignment: alinhamento,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: MascoteAvatar(tamanho: 32),
          ),
          const SizedBox(width: 8),
          Flexible(child: bolha),
        ],
      ),
    );
  }
}
