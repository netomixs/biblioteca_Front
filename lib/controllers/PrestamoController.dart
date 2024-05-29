import 'package:biblioteca_temporal/controllers/Api.dart';

class PrestamoController {
  static Future<Map> insert(
    String Fecha_FIn,
    String Id_Libro,
    String Id_Administrador,
    String Id_Lector,
  ) async {
    var valres = {
      "Fecha_FIn": Fecha_FIn,
      "Id_Libro": Id_Libro,
      "Id_Administrador": Id_Administrador,
      "Id_Lector": Id_Lector,
    };
    return await API.post("prestamo", valres);
  }

  static Future<Map> update(
    int id,
    String Fecha_FIn,
    String Fecha_Entrega,
  ) async {
    var valres = {"Fecha_FIn": Fecha_FIn, "Fecha_Entrega": Fecha_Entrega};
    return await API.update("prestamo", id, valres);
  }

  static Future<Map> getPrestamos() async {
    return API.get("prestamo");
  }

  static Future<Map> eliminar(int id) async {
    return await API.delete("prestamo", id);
  }
}
