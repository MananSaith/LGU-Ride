// To parse this JSON data, do
//
//     final vehicleModel = vehicleModelFromJson(jsonString);

import 'dart:convert';

VehicleModel vehicleModelFromJson(String str) => VehicleModel.fromJson(json.decode(str));

String vehicleModelToJson(VehicleModel data) => json.encode(data.toJson());

class VehicleModel {
  String? docId;
  int? index;
  String? vehicleName;
  String? icon;
  int? perKmPrice;
  String? image;

  VehicleModel({
    this.docId,
    this.index,
    this.vehicleName,
    this.perKmPrice,
    this.icon,
    this.image,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
    docId: json["docId"],
    index: json["index"],
    vehicleName: json["vehicleName"],
    perKmPrice: json["perKmPrice"],
    image: json["image"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "docID": docId,
    "index": index,
    "vehicleName": vehicleName,
    "perKmPrice": perKmPrice,
    "image": image,
    "icon": icon,
  };
}
