import 'package:choco_store_staff/data/api/model/base_model.dart';

class ProfileStore extends BaseModel {
//   {
//   "id": "string",
//   "namestore": "string",
//   "address": "string",
//   "manager": "string",
//   "coordinates": [
//     0
//   ],
//   "create_at": "2022-12-08T07:30:43.383Z",
//   "create_user": "string",
//   "update_user": "string",
//   "update_at": "2022-12-08T07:30:43.383Z"
// }
  String? id;
  String? nameStore;
  String? address;
  String? manager;
  List<dynamic>? coordinates;
  ProfileStore(
      {this.id, this.nameStore, this.address, this.manager, this.coordinates});
  ProfileStore.fromJson(dynamic json) : super.fromJson(json) {
    id = json["id"];
    nameStore = json['namestore'];
    address = json['address'];
    manager = json["manager"];
    coordinates = json["coordinates"];
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "namestore": nameStore,
      "address": address,
      "manager": manager,
      "coordinates": coordinates
    };
  }
}
