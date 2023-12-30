import 'package:test/data/model/CityModel.dart';

import '../apis/CityApi.dart';

class CityRepository {
  static CityApi _cityApi = CityApi();

  Future<dynamic> getcities({
    required int id,
  }) async {
    dynamic citiesJson = await _cityApi.getCities(id: id);
    
    if (citiesJson is String) {
      return citiesJson;
    }

    List<CityModel> allCities = [];
    allCities.clear();
    for (var i = 0; i < citiesJson.length; i++) {
      allCities.add(CityModel.fromJson(citiesJson[i]));
      print(allCities[i].name);
    }
    // print("==============repository===============");

    return allCities;
  }
}
