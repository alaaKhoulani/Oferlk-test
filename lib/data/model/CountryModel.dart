import '../../constants/Constants.dart';

class CountryModel {
  int? id;
  String? name;
  String? image;

  CountryModel({this.id, this.name, this.image});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image =  "${Constants.baseUrl}${json['image']}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
