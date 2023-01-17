import '../../base_model.dart';

class PartnerReponse extends BaseModel {
  // "id": "string",
  //   "name": "string",
  //   "address": "string",
  //   "logo": "string",
  //   "note": "string",
  String? id;
  String? name;
  String? address;
  String? logo;
  String? note;

  PartnerReponse({this.id, this.name, this.address, this.logo, this.note});

  factory PartnerReponse.fromJson(Map<String, dynamic> json) {
    return PartnerReponse(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        logo: json['logo'],
        note: json['note']);
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'logo': logo,
      'note': note
    };
  }
}
