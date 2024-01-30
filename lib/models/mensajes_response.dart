// To parse this JSON data, do
//
//     final mensajesresponse = mensajesresponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Mensajesresponse mensajesresponseFromJson(String str) =>
    Mensajesresponse.fromJson(json.decode(str));

String mensajesresponseToJson(Mensajesresponse data) =>
    json.encode(data.toJson());

class Mensajesresponse {
  bool ok;
  List<Mensaje> mensajes;

  Mensajesresponse({
    required this.ok,
    required this.mensajes,
  });

  factory Mensajesresponse.fromJson(Map<String, dynamic> json) =>
      Mensajesresponse(
        ok: json["ok"],
        mensajes: List<Mensaje>.from(
            json["mensajes"].map((x) => Mensaje.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
      };
}

class Mensaje {
  String de;
  String para;
  String mensaje;
  DateTime createdAt;
  DateTime updatedAt;

  Mensaje({
    required this.de,
    required this.para,
    required this.mensaje,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        de: json["de"],
        para: json["para"],
        mensaje: json["mensaje"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "de": de,
        "para": para,
        "mensaje": mensaje,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
