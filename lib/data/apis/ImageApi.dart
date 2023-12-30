import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test/constants/Constants.dart';

class ImageApi {
  Future<dynamic> getImages() async {
    try {
      var response = await http
          .get(Uri.parse("${Constants.baseUrl}api/get-slider-image"), headers: {
        "Accept": "application/json",
      });

      print(response.body);
      if (response.statusCode == 200) {
        List images = (json.decode(response.body))['data'];

        //     .map((e) => BookInfo.fromJson(e))
        //     .toList());
        return images;
      } else {
        return (json.decode(response.body) as Map<String, dynamic>)['msg'] as String;
      }
    } catch (e) {
      return "Some thing went wrong, please try again!";
    }
  }
}
