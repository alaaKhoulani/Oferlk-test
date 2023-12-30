import '../../constants/Constants.dart';

class ImageSliderItemModel {
  String? image;
  int? companyId;
  int? countryId;

  ImageSliderItemModel({this.image, this.companyId, this.countryId});

  ImageSliderItemModel.fromJson(Map<String, dynamic> json) {
    image = "${Constants.baseUrl}${json['image']}";
    companyId =json['company_id'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['company_id'] = this.companyId;
    data['country_id'] = this.countryId;
    return data;
  }
}