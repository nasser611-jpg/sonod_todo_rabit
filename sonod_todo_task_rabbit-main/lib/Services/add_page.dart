import 'dart:convert';
import 'package:http/http.dart' as http;

class apiProvider {
  static const String _baseURL =
      'https://jsonplaceholder.typicode.com';

  static get(String url) async {
    try {
      final response = await http.get(Uri.parse(url + _baseURL));
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    } catch (e) {
      rethrow;
    }
  }

  static post(String url, Map<String, dynamic> data) async {
    try {
      String jsondata = json.encode(data);
 
      final response =
          await http.post(Uri.parse( _baseURL+ url), body: jsondata, headers: {
        'Accept': 'application/json',
        'Content_Type': 'application/json',
      });
      print(_baseURL+url);
      if (response.statusCode == 200) {
        print('it\'s good');
        return true;
      }
    } catch (e) {
      print('not good');
      rethrow;
    }
  }

  static put(String url, Map<String, dynamic> data) async {
    try {
      String jsondata = json.encode(data);
      final response =
          await http.put(Uri.parse(url + _baseURL), body: jsondata, headers: {
        'Accept': 'application/json',
        'Content_Type': 'application/json',
      });
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  static delete(String url) async {
    try {
      final response = await http.delete(Uri.parse(url + _baseURL));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }
}
