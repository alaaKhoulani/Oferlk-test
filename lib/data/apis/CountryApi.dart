import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test/constants/Constants.dart';

class CountryApi{
  Future<dynamic> getAllCountries() async {
    try {
      var response = await http.get(
          Uri.parse("${Constants.baseUrl}api/get-all-countries"),
          headers: {
            "Accept": "application/json",
          });

      print(response.body);
      if (response.statusCode == 200) {
        List countries = (json.decode(response.body))['data'];
        return countries;
      } else {
        return (json.decode(response.body) as Map<String, dynamic>)['msg'] as String;
      }
    } catch (e) {
      return "some thing went wrong";
    }
  }
}