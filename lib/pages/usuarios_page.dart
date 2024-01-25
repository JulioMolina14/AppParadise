import 'package:chat_indisciplinadas/models/usuario.dart';
import 'package:chat_indisciplinadas/services/authserices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final usuarios = [
    Usuario(
        online: true,
        nombre: 'Julio',
        email: 'Juliocesarmolina@unicesar.edu.co',
        uid: '1'),
    Usuario(
        online: true,
        nombre: 'Alejandra',
        email: 'Alejandramanjarrez@unicesar.edu.co',
        uid: '2'),
    Usuario(
        online: false,
        nombre: 'Maria',
        email: 'Mariainespacheco@unicesar.edu.co',
        uid: '3')
  ];
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final usuario = authServices.usuario;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          usuario.nombre,
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'Login');
              AuthServices.deleteToken();
            }),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.offline_bolt_outlined,
              color: Colors.red,
            ),
            /* child: Icon(
              Icons.check_circle,
              color: Colors.blue,
            ), */
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUser,
        child: _listviewseparated(),
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.red,
          ),
          waterDropColor: Colors.red,
        ),
      ),
    );
  }

  ListView _listviewseparated() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuarioListile(usuarios[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuarios.length);
  }

  ListTile _usuarioListile(Usuario usuarios) {
    return ListTile(
      title: Text(usuarios.nombre),
      subtitle: Text(usuarios.email),
      leading: CircleAvatar(
        child: Text(usuarios.nombre.substring(0, 2)),
        backgroundColor: Colors.red,
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuarios.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _cargarUser() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
