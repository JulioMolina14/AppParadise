import 'package:flutter/material.dart';

class BotonLabel extends StatelessWidget {
  final String text;
  final Function onPressed;

  const BotonLabel({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      child: Container(
        width: double.infinity,
        child: Center(child: Text(text)),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: StadiumBorder(),
      ),
    );
  }
}
