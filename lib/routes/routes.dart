import 'package:chat_indisciplinadas/pages/chat.dart';
import 'package:chat_indisciplinadas/pages/loading.dart';
import 'package:chat_indisciplinadas/pages/login.dart';
import 'package:chat_indisciplinadas/pages/registro.dart';
import 'package:chat_indisciplinadas/pages/usuarios_page.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'User': (_) => UserPage(),
  'Chat': (_) => Chat_UserPage(),
  'Login': (_) => Login_UserPage(),
  'Register': (_) => Register_UserPage(),
  'Loading': (_) => Loading_UserPage(),
};
