import 'package:test/data/apis/ImageApi.dart';
import 'package:test/data/model/ImageSliderItemModel.dart';

class ImageSliderRepository {
  static ImageApi _imageApi = ImageApi();

  Future<dynamic> getimages() async {
    dynamic imagesJson = await _imageApi.getImages();

    if (imagesJson is String) {
      return imagesJson;
    }

    List<ImageSliderItemModel> allImages = [];
    allImages.clear();
    for (var i = 0; i < imagesJson.length; i++) {
      allImages.add(ImageSliderItemModel.fromJson(imagesJson[i]));
      print("------------------------------------");
      print(allImages[i].image);
    }
    // print("==============repository===============");

    return allImages;
  }
}
