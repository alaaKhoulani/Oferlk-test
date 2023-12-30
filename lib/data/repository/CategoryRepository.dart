import 'package:test/data/apis/CategoryApi.dart';

import '../model/CategoryModel.dart';

class CategoryRepository {
  CategoryApi _categoryApi = CategoryApi();

  Future<dynamic> getcategories({
    required int id,
  }) async {
    dynamic categoriesJson = await _categoryApi.getCategories(id: id);

    if (categoriesJson is String) {
      return categoriesJson;
    }

    List<CategoryModel> allCats = [];
    allCats.clear();
    for (var i = 0; i < categoriesJson.length; i++) {
      allCats.add(CategoryModel.fromJson(categoriesJson[i]));
      print(allCats[i].image);
    }
    // print("==============repository===============");

    return allCats;
  }
}
