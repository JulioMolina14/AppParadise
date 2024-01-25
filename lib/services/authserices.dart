import 'dart:convert';
import 'package:chat_indisciplinadas/global/variables-entorno.dart';
import 'package:chat_indisciplinadas/models/login_response.dart';
import 'package:chat_indisciplinadas/models/usuario.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthServices with ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;
  final _storage = new FlutterSecureStorage();

  bool get autenticando => _autenticando;

  /* Getter del token */

  static Future<String> getToken() async {
    final _storage_estac = new FlutterSecureStorage();
    final token_estac = await _storage_estac.read(key: 'token');
    return token_estac!;
  }

  static Future<void> deleteToken() async {
    final _storage_estac = new FlutterSecureStorage();
    await _storage_estac.delete(key: 'token');
  }

  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  Future<bool> loginUser(String email, String contrasena) async {
    this.autenticando = true;

    /* print(' aqui va el correo : ${email}'); */
    final data = {"email": email, "contrasena": contrasena};
    /* print(' aqui va la data : ${data}'); */
    final resp = await http.post(Uri.parse('${VariableEntornos.apiUrl}/login'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    /* print('aquiesta el body : ' + resp.body); */
    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      this._guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future registernUser(String nombre, String email, String contrasena) async {
    this.autenticando = true;
    final datos = {"nombre": nombre, "email": email, "contrasena": contrasena};
    final resp = await http.post(
        Uri.parse('${VariableEntornos.apiUrl}/login/new'),
        body: jsonEncode(datos),
        headers: {'Content-Type': 'application/json'});
    /*  print('aqui esta el registro del body : ' + resp.body); */
    this.autenticando = false;
    if (resp.statusCode == 200) {
      final registroResponse = loginResponseFromJson(resp.body);
      this.usuario = registroResponse.usuario;
      this._guardarToken(registroResponse.token);
      return true;
    } else {
      final respoBody = jsonDecode(resp.body);
      return respoBody['mensaje'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');

    try {
      final resp = await http.get(
          Uri.parse('${VariableEntornos.apiUrl}/login/renew'),
          headers: {'Content-Type': 'application/json', 'x-token': token!});

      if (resp.statusCode == 200) {
        final registroResponse = loginResponseFromJson(resp.body);
        this.usuario = registroResponse.usuario;
        this._guardarToken(registroResponse.token);
        return true;
      } else {
        this.logout();
        return false;
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
      return false;
    }
  }

  Future _guardarToken(String token) {
    return _storage.write(key: 'token', value: token);
  }

  Future logout() {
    return _storage.delete(key: 'token');
  }
}
