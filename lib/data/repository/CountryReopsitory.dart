import 'package:test/data/apis/CategoryApi.dart';
import 'package:test/data/apis/CountryApi.dart';
import 'package:test/data/model/CountryModel.dart';


class CountryRepository {
 CountryApi _countryApi=CountryApi();
  Future<dynamic> getcategories() async {
    dynamic json = await _countryApi.getAllCountries();

    if (json is String) {
      return json;
    }
    List<CountryModel> allCountries = [];
    allCountries.clear();
    for (var i = 0; i < json.length; i++) {
      allCountries.add(CountryModel.fromJson(json[i]));
      print(allCountries[i].image);
    }
    // print("==============repository===============");

    return allCountries;
  }
}
