import 'package:biblioteca_temporal/controllers/Api.dart';

class GeneroController {
 
    static Future<Map> getGeneros() async {
    return API.get("genero");
  }
}