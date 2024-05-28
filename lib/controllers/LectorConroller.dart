import 'package:biblioteca_temporal/controllers/Api.dart';

class LectorController {
  static Future<Map> insert(String UDI, int idPersona) async {
    var valres = {
      "UDI": UDI,
      "Id_Persona": idPersona,
    };
    return await API.post("lector", valres);
  }

  static Future<Map> getLector(int id) async {
    return API.get("lector/${id}");
  }
}
