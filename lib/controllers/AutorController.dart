import 'package:biblioteca_temporal/controllers/Api.dart';

class AutorController {
 
    static Future<Map> getAutores() async {
    return API.get("autor/persona");
  }
}