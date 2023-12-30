import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test/constants/Constants.dart';

class CategoryApi{
  Future<dynamic> getCategories({required int id}) async {
    try {

      var response = await http.get(
          Uri.parse("${Constants.baseUrl}api/get-city-categories/$id"),
          headers: {
            "Accept": "application/json",
          });
      
      
      print("cattttttttttttttttttttttttttttttttttttttttttt");
      print(response.body);
      if (response.statusCode == 200) {
        List catigories = (json.decode(response.body))['data'];
        return catigories;
      } else {
        return (json.decode(response.body) as Map<String, dynamic>)['msg'];
      }
    
    } catch (e) {
      return "Some thing went wrong, please try again!";
    }
  }
}