import 'package:chat_indisciplinadas/helpers/mostrar_alerta.dart';
import 'package:chat_indisciplinadas/services/authserices.dart';
import 'package:chat_indisciplinadas/widgets/boton_label.dart';
import 'package:chat_indisciplinadas/widgets/custom_inputs.dart';
import 'package:chat_indisciplinadas/widgets/labels.dart';
import 'package:chat_indisciplinadas/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register_UserPage extends StatelessWidget {
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
              Logo(titulo: 'Registro'),
              _Form(),
              Labels(
                  ruta: 'Login',
                  textolabeazul: 'Ingresa Con Una Cuenta',
                  textolabegris: '¿Ya Tienes Cuenta?'),
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
  final _corre = TextEditingController();
  final _password = TextEditingController();
  final _nombre = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          Custom_Input(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            textController: _nombre,
            keyboardType: TextInputType.name,
            isPhone: false,
          ),
          Custom_Input(
            icon: Icons.email,
            placeholder: 'Correo',
            textController: _corre,
            keyboardType: TextInputType.emailAddress,
            isPhone: false,
          ),
          Custom_Input(
            icon: Icons.password_rounded,
            placeholder: 'Contraseña',
            textController: _password,
            keyboardType: TextInputType.text,
            isPhone: true,
          ),
          BotonLabel(
              text: 'Ingrese',
              onPressed: authService.autenticando
                  ? null
                  : () async {
                      final registroOK = await authService.registernUser(
                          _nombre.text.trim(),
                          _corre.text.trim(),
                          _password.text.trim());

                      if (registroOK == true) {
                        Navigator.pushReplacementNamed(context, 'User');
                      } else {
                        mostarAlerta(
                            context, 'Registro incorrecto', registroOK);
                      }
                    })
        ],
      ),
    );
  }
}
