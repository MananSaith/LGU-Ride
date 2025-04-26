// To parse this JSON data, do
//
//     final riderVehicleModel = riderVehicleModelFromJson(jsonString);

import 'dart:convert';

RiderVehicleModel riderVehicleModelFromJson(String str) =>
    RiderVehicleModel.fromJson(json.decode(str));

class RiderVehicleModel {
  String? docId;
  String? vehicleName;
  String? vehiclePlateNumber;
  int? createdAt;
  String? vehicleDocuments;
  String? licenseCardImage;
  String? model;

  RiderVehicleModel({
    this.docId,
    this.vehicleName,
    this.vehiclePlateNumber,
    this.createdAt,
    this.vehicleDocuments,
    this.licenseCardImage,
    this.model,
  });

  factory RiderVehicleModel.fromJson(Map<String, dynamic> json) =>
      RiderVehicleModel(
        docId: json["docID"],
        vehicleName: json["vehicleName"],
        vehiclePlateNumber: json["vehiclePlateNumber"],
        createdAt: json["createdAt"],
        vehicleDocuments: json["vehicleDocuments"],
        licenseCardImage: json["licenseCardImage"],
        model: json["model"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "docID": docID,
        "vehicleName": vehicleName,
        "vehiclePlateNumber": vehiclePlateNumber,
        "createdAt": createdAt,
        "vehicleDocuments": vehicleDocuments,
        "licenseCardImage": licenseCardImage,
        "model": model,
      };
}
