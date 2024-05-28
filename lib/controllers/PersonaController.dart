import 'package:biblioteca_temporal/controllers/Api.dart';

class PersonaController {
    static Future<Map> getLibro(int id) async {
    return API.get("persona/${id}");
  }
  static Future<Map> insert(String Nombre, String Apellido_P, String Apellido_M,
      String Nacimiento, String Sexo ) async {
    var valres = {
      "Nombre": Nombre,
      "Apellido_P": Apellido_P,
      "Apellido_M": Apellido_M,
      "Nacimiento": Nacimiento,
      "Sexo": Sexo,
    };
    return await API.post("persona", valres);
  }

  static Future<Map> actualizar(int id, String Nombre, String Apellido_P,
      String Apellido_M, String Nacimiento, String Sexo, int autor) async {
    var valres = {
      "Nombre": Nombre,
      "Apellido_P": Apellido_P,
      "Apellido_M": Apellido_M,
      "Nacimiento": Nacimiento,
      "Sexo": Sexo,
    };
    return await API.update("persona", id, valres);
  }

  static Future<Map> eliminar(int id) async {
    return await API.delete("persona", id);
  }
}
