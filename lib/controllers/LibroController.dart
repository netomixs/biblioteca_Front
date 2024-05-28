import 'package:biblioteca_temporal/controllers/Api.dart';

class LibroController {
  static Future<Map> getLibros() async {
    return API.get("libro");
  }

  static Future<Map> getLibro(int id) async {
    return API.get("libro/${id}");
  }

  static Future<Map> insert(
      String titulo,
      String ISBN,
      String imagen,
      String desc,
      String pub,
      int existencia,
      int editorial,
      String codigo,
      int genero,
      int autor) async {
    var valres = {
      "Imagen": imagen,
      "ISBN": ISBN,
      "Titulo": titulo,
      "Descripcion": desc,
      "Fecha_Publicacion": pub,
      "Feha_Adquicicion": DateTime.now(),
      "Existencias": existencia,
      "Es_Prestable": "1",
      "Id_Tipo": 1,
      "Codigo": codigo,
      "Id_Editorial": editorial,
      "Id_Genero": genero,
      "Id_Autor": autor,
    };
    return await API.post("libro", valres);
  }

  static Future<Map> actualizar(
      int id,
      String titulo,
      String ISBN,
      String imagen,
      String desc,
      String pub,
      int existencia,
      int editorial,
      String codigo,
      int genero,
      int autor) async {
    var valres = {
      "Imagen": imagen,
      "ISBN": ISBN,
      "Titulo": titulo,
      "Descripcion": desc,
      "Fecha_Publicacion": pub,
      "Feha_Adquicicion": DateTime.now(),
      "Existencias": existencia,
      "Es_Prestable": "1",
      "Id_Tipo": 1,
      "Codigo": codigo,
      "Id_Editorial": editorial,
      "Id_Genero": genero,
      "Id_Autor": autor,
    };
    return await API.update("libro", id, valres);
  }

  static Future<Map> actualizarImagen(int id, String imagen) async {
    var valres = {"Imagen": imagen};
    return await API.post("libro/${id}/image", valres);
  }
  static Future<Map> eliminar(int id) async {
    return await API.delete("libro", id);
  }
}
