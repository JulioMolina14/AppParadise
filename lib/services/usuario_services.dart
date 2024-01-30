import 'package:chat_indisciplinadas/global/variables-entorno.dart';
import 'package:chat_indisciplinadas/models/usuario.dart';
import 'package:chat_indisciplinadas/models/usuario_response.dart';
import 'package:chat_indisciplinadas/services/authserices.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http
          .get(Uri.parse('${VariableEntornos.apiUrl}/usuarios'), headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthServices.getToken()
      });

      final usuariosRenpose = usuarioReponseFromJson(resp.body);

      return usuariosRenpose.usuarios;
    } catch (e) {
      return [];
    }
  }
}
