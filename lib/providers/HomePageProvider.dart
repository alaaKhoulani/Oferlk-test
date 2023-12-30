import 'package:flutter/material.dart';
import 'package:test/data/apis/CategoryApi.dart';
import 'package:test/data/repository/CategoryRepository.dart';
import 'package:test/data/repository/CountryReopsitory.dart';
import 'package:test/data/repository/ImageSliderRepository.dart';

class HomePageProvider extends ChangeNotifier {
  int currentCity = -1;
  int currentImage = 0;
  dynamic categoriesList;
  dynamic citiesList;
  dynamic imagesList;
  dynamic countryList;

  selectCity(int index) {
    this.currentCity = index;
    notifyListeners();
  }

  changecurrentImage(int index) {
    this.currentImage = index;
    notifyListeners();
  }

  Future<dynamic> getImagesFromApi() async {
    dynamic responce = await ImageSliderRepository().getimages();
    notifyListeners();
    return responce;
  }

  getCountriesFromApi() async {
    
    countryList = await CountryRepository().getcategories();
    notifyListeners();
  }

  Future<dynamic> getCategories(int id) async {
    // categoriesList=null;
    this.categoriesList = await CategoryRepository().getcategories(id: id);
    notifyListeners();
  }

  Future<dynamic> getcities(int id) async {
    
    this.citiesList = await CategoryApi().getCategories(id: id);
    notifyListeners();
  }

  Future<dynamic> getImages() async {
    this.imagesList = await ImageSliderRepository().getimages();
    notifyListeners();
  }
}
