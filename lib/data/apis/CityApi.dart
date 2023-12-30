import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test/constants/Constants.dart';

class CityApi{
  Future<dynamic> getCities({required int id}) async {
    try {
      var response = await http.get(
          Uri.parse("${Constants.baseUrl}api/country/$id"),
          headers: {
            "Accept": "application/json",
          });

      print(response.body);
      if (response.statusCode == 200) {
        List books = (json.decode(response.body))['data'];
        return books;
      } else {
        return (json.decode(response.body) as Map<String, dynamic>)['msg'] as String;
      }
    } catch (e) {
      return "Some thing went wrong, please try again!";
    }
  }
}