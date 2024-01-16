import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String textolabegris;
  final String textolabeazul;

  const Labels(
      {super.key,
      required this.ruta,
      required this.textolabegris,
      required this.textolabeazul});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            textolabegris,
            style: TextStyle(
                color: Colors.black45,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: Text(
              textolabeazul,
              style: TextStyle(
                  color: Colors.red[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, ruta);
            },
          ),
        ],
      ),
    );
  }
}
