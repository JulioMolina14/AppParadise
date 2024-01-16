import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String titulo;
  const Logo({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Image(
              image: AssetImage('assets/LoginParadise5.png'),
            ),
            Text(
              titulo,
              style: TextStyle(fontSize: 25.0),
            )
          ],
        ),
      ),
    );
  }
}
