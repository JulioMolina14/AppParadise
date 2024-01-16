import 'package:flutter/material.dart';

class Custom_Input extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPhone;

  const Custom_Input(
      {super.key,
      required this.icon,
      required this.placeholder,
      required this.textController,
      required this.keyboardType,
      required this.isPhone});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]),
      child: TextField(
        controller: textController,
        autocorrect: false,
        keyboardType: keyboardType,
        obscureText: isPhone,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.red,
            ),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.blueGrey)),
      ),
    );
  }
}
