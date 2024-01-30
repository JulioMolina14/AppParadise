// To parse this JSON data, do
//
//     final usuarioReponse = usuarioReponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat_indisciplinadas/models/usuario.dart';

UsuarioReponse usuarioReponseFromJson(String str) =>
    UsuarioReponse.fromJson(json.decode(str));

String usuarioReponseToJson(UsuarioReponse data) => json.encode(data.toJson());

class UsuarioReponse {
  UsuarioReponse({
    required this.ok,
    required this.usuarios,
  });

  bool ok;
  List<Usuario> usuarios;

  factory UsuarioReponse.fromJson(Map<String, dynamic> json) => UsuarioReponse(
        ok: json["ok"],
        usuarios: List<Usuario>.from(
            json["usuarios"].map((x) => Usuario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
      };
}
