import 'dart:io' show Platform;

import 'package:chat_indisciplinadas/models/mensajes_response.dart';
import 'package:chat_indisciplinadas/services/authserices.dart';
import 'package:chat_indisciplinadas/services/chat_usuario.dart';
import 'package:chat_indisciplinadas/services/socket.dart';
import 'package:chat_indisciplinadas/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat_UserPage extends StatefulWidget {
  @override
  State<Chat_UserPage> createState() => _Chat_UserPageState();
}

class _Chat_UserPageState extends State<Chat_UserPage>
    with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  late ChatService chatService;
  late SocketService socketService;
  late AuthServices authServices;

  List<Chat_Message> _messages = [];

  bool _escribiendo = false;

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authServices = Provider.of<AuthServices>(context, listen: false);

    socketService.socket.on('mensaje-personal', _escuchandoFlutter);

    _cargarHistoria(this.chatService.usuarioSend.uid);
  }

  void _escuchandoFlutter(dynamic data) {
    Chat_Message chatmensaje = new Chat_Message(
      animationController: AnimationController(
          vsync: this, duration: Duration(microseconds: 300)),
      texto: data['mensaje'],
      uid: data['de'],
    );
    setState(() {
      _messages.insert(0, chatmensaje);
    });
  }

  @override
  Widget build(BuildContext context) {
    final usuarioChat = chatService.usuarioSend.nombre;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Column(
          children: [
            Container(
              child: Column(
                children: [
                  CircleAvatar(
                    child: Center(
                        child: Text(usuarioChat.substring(0, 2),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12))),
                    backgroundColor: Colors.pinkAccent,
                    maxRadius: 14,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Alejandra',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemBuilder: (_, i) => _messages[i],
                itemCount: _messages.length,
                physics: BouncingScrollPhysics(),
                reverse: true,
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmit,
            onChanged: (String texto) {
              setState(() {
                if (texto.trim().length > 0) {
                  _escribiendo = true;
                } else {
                  _escribiendo = false;
                }
              });
            },
            decoration: InputDecoration.collapsed(hintText: 'Enviar Mensaje'),
            focusNode: _focusNode,
          )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS
                ? CupertinoButton(
                    child: Text('Enviar'),
                    onPressed: _escribiendo
                        ? () => _handleSubmit(_textController.text.trim())
                        : null,
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.red[300]),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: _escribiendo
                            ? () => _handleSubmit(_textController.text.trim())
                            : null,
                        icon: Icon(
                          Icons.send,
                        ),
                      ),
                    ),
                  ),
          )
        ],
      ),
    ));
  }

  _handleSubmit(String texto) {
    print(texto);
    _textController.clear();
    _focusNode.requestFocus();
    final newMessage = new Chat_Message(
      texto: texto,
      uid: authServices.usuario.uid,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _escribiendo = false;
    });
    this.socketService.emit('mensaje-personal', {
      'de': authServices.usuario.uid,
      'para': chatService.usuarioSend.uid,
      'mensaje': texto
    });
  }

  @override
  void dispose() {
    // TODO: implement dispos
    for (Chat_Message message in _messages) {
      message.animationController.dispose();
    }
    socketService.socket.off('mensaje-personal');
    super.dispose();
  }

  void _cargarHistoria(String usuariuoID) async {
    List<Mensaje> chat = await this.chatService.getChat(usuariuoID);

    final historial = chat.map((mensaje) => new Chat_Message(
          texto: mensaje.mensaje,
          uid: mensaje.de,
          animationController: new AnimationController(
              vsync: this, duration: Duration(microseconds: 0))
            ..forward(),
        ));
    _messages.insertAll(0, historial);
  }
}
