import 'package:biblioteca_temporal/controllers/Api.dart';

class UsuarioController {
  static Future<Map> insert(String Usuario, String Password,
      String Clave_Empleado, int Id_Persona, int Nivel) async {
    var valres = {
      "Usuario": Usuario,
      "Password": Password,
      "Clave_Empleado": Clave_Empleado,
      "Id_Persona": Id_Persona,
      "Nivel": Nivel,
    };
    return await API.post("usuario", valres);
  }
}
