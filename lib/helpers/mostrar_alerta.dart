import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostarAlerta(BuildContext context, String titulo, String subtitulo) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(titulo),
      content: Text(subtitulo),
      actions: [
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
          elevation: 5,
          textColor: Colors.blue,
        )
      ],
    ),
  );
}
