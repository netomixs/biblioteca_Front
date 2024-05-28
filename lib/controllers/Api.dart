import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class API {
  // ignore: non_constant_identifier_names
  static String URL = "https://biblioteca-api.alwaysdata.net/";

  static Future<Map> get(String ruta) async {
    try {
      var response = await http.get(Uri.parse(URL + ruta));
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<dynamic, dynamic>;
      } else {
        return {
          'error': 'Failed to load data, status code: ${response.statusCode}'
        };
      }
    } catch (e) {
      print(e);
      return {'error': ' Fallo${e}'};
    }
  }

 static Future<Map<String, dynamic>> post(
      String ruta, Map<dynamic, dynamic> data) async {
    var request = http.MultipartRequest('POST', Uri.parse(URL + ruta));

    data.forEach((key, value) async {
      if (value is File) {
        var stream =
            // ignore: deprecated_member_use
            http.ByteStream(DelegatingStream.typed(value.openRead()));
        var length = await value.length();
        var multipartFile = http.MultipartFile('Imagen', stream, length,
            filename: basename(value.path));
        request.files.add(multipartFile);
      } else {
        request.fields[key] = value.toString();
      }
    });

    try {
      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        return jsonDecode(responseData.body) as Map<String, dynamic>;
      } else {
        return {
          'error': 'Failed to load data, status code: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'error': 'Failed to load data, error: $e'};
    }
  }

  static Future<Map<String, dynamic>> update(
      String ruta, int id, Map<dynamic, dynamic> data) async {
    var request = http.MultipartRequest('POST', Uri.parse("$URL$ruta/$id"));

    data.forEach((key, value) async {
      if (value is File) {
        var stream =
            // ignore: deprecated_member_use
            http.ByteStream(DelegatingStream.typed(value.openRead()));
        var length = await value.length();
        var multipartFile = http.MultipartFile('Imagen', stream, length,
            filename: basename(value.path));
        request.files.add(multipartFile);
      } else {
        request.fields[key] = value.toString();
      }
    });

    try {
      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        return jsonDecode(responseData.body) as Map<String, dynamic>;
      } else {
        return {
          'error': 'Failed to load data, status code: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'error': 'Failed to load data, error: $e'};
    }
  }

  static Future<Map<String, dynamic>> delete(String ruta, int id) async {
    try {
      final response = await http.delete(Uri.parse("$URL$ruta/$id"));

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        return {
          'error': 'Failed to delete data, status code: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'error': 'Failed to delete data, error: $e'};
    }
  }
}
