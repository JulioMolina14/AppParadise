import 'package:chat_indisciplinadas/global/variables-entorno.dart';
import 'package:chat_indisciplinadas/services/authserices.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum StatusServidor { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  StatusServidor _servidor = StatusServidor.Connecting;
  late IO.Socket _socket;

  get serveStatus => this._servidor;
  get socket => this._socket;
  get emit => this._socket.emit;

  void conectado() async {
    final token = await AuthServices.getToken();
    this._socket = IO.io(VariableEntornos.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token}
    });

    this._socket.on('connect', (_) {
      print('connectado en flutter');
      _servidor = StatusServidor.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      print('desconectado en flutter');
      _servidor = StatusServidor.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    this._socket.disconnect();
  }
}
