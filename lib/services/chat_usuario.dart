import 'package:chat_indisciplinadas/global/variables-entorno.dart';
import 'package:chat_indisciplinadas/models/mensajes_response.dart';
import 'package:chat_indisciplinadas/models/usuario.dart';
import 'package:chat_indisciplinadas/services/authserices.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  late Usuario usuarioSend;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final resp = await http.get(
        Uri.parse('${VariableEntornos.apiUrl}/mensajes/$usuarioID'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthServices.getToken()
        });

    final mensajeResp = mensajesresponseFromJson(resp.body);

    return mensajeResp.mensajes;
  }
}
