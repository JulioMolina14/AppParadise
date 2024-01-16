import 'package:chat_indisciplinadas/widgets/boton_label.dart';
import 'package:chat_indisciplinadas/widgets/custom_inputs.dart';
import 'package:chat_indisciplinadas/widgets/labels.dart';
import 'package:chat_indisciplinadas/widgets/logo.dart';
import 'package:flutter/material.dart';

class Login_UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      minimum: EdgeInsets.only(right: 20.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Logo(titulo: 'Club Paradise'),
              _Form(),
              Labels(
                  ruta: 'Register',
                  textolabeazul: 'Crear Una Cuenta Ahora',
                  textolabegris: '¿No Eres Parte De Paradise?'), //
              Text(
                'Terminos y condiciones',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _phone = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          Custom_Input(
            icon: Icons.phone_android_rounded,
            placeholder: 'Telefono',
            textController: _phone,
            keyboardType: TextInputType.phone,
            isPhone: false,
          ),
          Custom_Input(
            icon: Icons.password_rounded,
            placeholder: 'Contraseña',
            textController: _password,
            keyboardType: TextInputType.phone,
            isPhone: true,
          ),
          BotonLabel(
              text: 'Ingrese',
              onPressed: () {
                print(_password.text);
                print(_phone.text);
              })
        ],
      ),
    );
  }
}
