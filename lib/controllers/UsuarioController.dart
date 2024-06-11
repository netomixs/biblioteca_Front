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
    static Future<Map> actualizar(int id,String Usuario, 
      String Clave_Empleado,int Nivel)  async {
    var valres = {
      "Usuario": Usuario,
      "Clave_Empleado": Clave_Empleado,
      "Nivel":Nivel
 
    };
    return await API.update("usuario",id ,valres);
  }
    static Future<Map> getUsuario(int id) async {
    return API.get("usuario/${id}");
  }
}
