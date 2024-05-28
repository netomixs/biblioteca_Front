import 'package:biblioteca_temporal/controllers/Api.dart';

class EditorialController {
    static Future<Map> getEditoriales() async {
    return API.get("editorial");
  }
}