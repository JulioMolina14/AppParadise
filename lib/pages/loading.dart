import 'package:chat_indisciplinadas/pages/login.dart';
import 'package:chat_indisciplinadas/pages/usuarios_page.dart';
import 'package:chat_indisciplinadas/services/authserices.dart';
import 'package:chat_indisciplinadas/services/socket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loading_UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: chekLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future chekLoginState(BuildContext context) async {
    final authServices = Provider.of<AuthServices>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final auntenticado = await authServices.isLoggedIn();

    if (auntenticado) {
      socketService.conectado();
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 0),
              pageBuilder: (_, __, ___) => UserPage()));
      print('${auntenticado} estoy on en la aplicacion');
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 0),
              pageBuilder: (_, __, ___) => Login_UserPage()));
      print('${auntenticado} estoy off en la aplicacion');
    }
  }
}
