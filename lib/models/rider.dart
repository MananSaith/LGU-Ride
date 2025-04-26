// To parse this JSON data, do
//
//     final riderModel = riderModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

RiderModel riderModelFromJson(String str) =>
    RiderModel.fromJson(json.decode(str));

String riderModelToJson(RiderModel data) =>
    json.encode(data.toJson(data.docId.toString()));

class RiderModel {
  String? docId;
  String? name;
  String? phoneNumber;
  String? image;
  String? email;
  String? cnic;
  String? cnicFront;
  String? cnicBack;
  String? rideID;
  String? cityID;
  String? cityName;
  String? vehicleTypeID;
  bool? isOnline;
  bool? isBusy;
  bool? isApproved;
  bool? isBlocked;
  int? createdAt;
  double? lat;
  double? lng;

  RiderModel({
    this.docId,
    this.name,
    this.phoneNumber,
    this.createdAt,
    this.isOnline,
    this.cnicFront,
    this.cnicBack,
    this.isApproved,
    this.isBlocked,
    this.email,
    this.cnic,
    this.image,
    this.isBusy,
    this.rideID,
    this.cityID,
    this.cityName,
    this.vehicleTypeID,
    this.lat,
    this.lng,
  });

  factory RiderModel.fromJson(Map<String, dynamic> json) => RiderModel(
        docId: json["docID"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        createdAt: json["createdAt"],
        image: json["image"],
        email: json["email"],
        isOnline: json["isOnline"],
        cnic: json["cnic"],
        cnicFront: json["cnicFront"],
        cnicBack: json["cnicBack"],
        isApproved: json["isApproved"],
        isBlocked: json["isBlocked"],
        isBusy: json["isBusy"],
        rideID: json["rideID"],
        cityID: json["cityID"],
        cityName: json["cityName"],
        vehicleTypeID: json["vehicleTypeID"],
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "docID": docID,
        "name": name,
        "phoneNumber": phoneNumber,
        "image": image,
        "createdAt": Timestamp.now().millisecondsSinceEpoch,
        "email": email,
        "isOnline": isOnline,
        "cnicFront": cnicFront,
        "cnicBack": cnicBack,
        "cnic": cnic,
        "isBlocked": isBlocked,
        "isApproved": isApproved,
        "isBusy": isBusy,
        "rideID": rideID,
        "cityName": cityName,
        "cityID": cityID,
        "vehicleTypeID": vehicleTypeID,
        "lat": lat,
        "lng": lng,
      };
}
