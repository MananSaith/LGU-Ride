// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  String? docId;
  String? name;

  CityModel({
    this.docId,
    this.name,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    docId: json["docID"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "docID": docId,
    "name": name,
  };
}
