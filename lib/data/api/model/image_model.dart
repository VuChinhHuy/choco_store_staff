class ImageModel {
//   "number": 0,
  //       "src": "string",
  //       "alt": "string"
  int? number;
  String? src;
  String? alt;

  ImageModel({this.number, this.src, this.alt});
  factory ImageModel.fromJson(Map<dynamic, dynamic> json) {
    return ImageModel(
        number: json['number'], src: json['src'], alt: json['alt']);
  }
  Map<String, dynamic> toJson() {
    return {'number': number, 'src': src, 'alt': alt};
  }
}
