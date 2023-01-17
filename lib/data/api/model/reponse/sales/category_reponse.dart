// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../base_model.dart';

class CategoryReponse extends BaseModel {
  // "id": "string",
  //   "name": "string",
  //   "note": "string",
  //   "display": true,
  String? id;
  String? name;
  String? note;
  bool display = true;
  CategoryReponse({this.id, this.name, this.note, this.display = true});

  factory CategoryReponse.fromJson(Map<String, dynamic> json) {
    return CategoryReponse(
        id: json['id'],
        name: json['name'],
        note: json['note'],
        display: json['display']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'note': note, 'display': display};
  }

  @override
  String toString() {
    return 'CategoryReponse(id: $id, name: $name, note: $note, display: $display)';
  }
}
