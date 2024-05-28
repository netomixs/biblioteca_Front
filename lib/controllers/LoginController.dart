import 'package:biblioteca_temporal/controllers/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginController {
  static Future<Map> Login(String email, String password) async {

    var datos={"Usuario":email,"Password":password};
 return await API.post("login", datos);
 
  }
  static Future<void> saveValue(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

// Leer un valor
static Future<String?> getValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}
}
