// To parse this JSON data, do
//
//     final rideModel = rideModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

RideModel rideModelFromJson(String str) => RideModel.fromJson(json.decode(str));

class RideModel {
  String? docId;
  Timestamp? createdAt;
  String? from;
  String? to;
  String? riderId;
  String? riderName;
  String? riderImage;
  String? riderPhoneNumber;
  num? distance;
  String? travelTime;
  num? amount;
  bool? isCompleted;
  bool? isArrived;
  bool? isCancelled;
  bool? isPending;
  bool? isActive;
  bool? isProcessed;
  num? fromLat;
  num? fromLng;
  num? toLat;
  num? toLng;
  String? userId;
  String? userName;
  String? userImage;
  String? userPhoneNumber;
  String? vehicleType;
  String? vehicleIcon;

  List<String>? rejectedUsers;

  RideModel({
    this.docId,
    this.createdAt,
    this.from,
    this.to,
    this.riderId,
    this.riderName,
    this.riderImage,
    this.riderPhoneNumber,
    this.distance,
    this.travelTime,
    this.amount,
    this.isCompleted,
    this.isCancelled,
    this.isPending,
    this.isArrived,
    this.fromLat,
    this.fromLng,
    this.toLat,
    this.toLng,
    this.userId,
    this.userName,
    this.isProcessed,
    this.userImage,
    this.userPhoneNumber,
    this.vehicleType,
    this.rejectedUsers,
    this.vehicleIcon,
    this.isActive,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) => RideModel(
        docId: json["docID"],
        createdAt: json["createdAt"],
        from: json["from"],
        to: json["to"],
        riderId: json["riderID"],
        riderName: json["riderName"],
        riderImage: json["riderImage"],
        riderPhoneNumber: json["riderPhoneNumber"],
        distance: json["distance"],
        travelTime: json["travelTime"],
        amount: json["amount"],
        isCompleted: json["isCompleted"],
        isCancelled: json["isCancelled"],
        fromLat: json["fromLat"],
        fromLng: json["fromLng"],
        toLat: json["toLat"],
        toLng: json["toLng"],
        userId: json["userID"],
        userName: json["userName"],
        isProcessed: json["isProcessed"],
        userImage: json["userImage"],
        userPhoneNumber: json["userPhoneNumber"],
        isPending: json["isPending"],
        vehicleType: json["vehicleType"],
        isArrived: json["isArrived"],
    vehicleIcon: json["vehicleIcon"],
    isActive: json["isActive"],
        rejectedUsers: json["rejectedUsers"] == null
            ? []
            : List<String>.from(json["rejectedUsers"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson(String docID) => {
        "docID": docID,
        "createdAt": Timestamp.now(),
        "from": from,
        "to": to,
        "riderID": riderId,
        "riderName": riderName,
        "riderImage": riderImage,
        "riderPhoneNumber": riderPhoneNumber,
        "distance": distance,
        "travelTime": travelTime,
        "amount": amount,
        "isCompleted": false,
        "isCancelled": false,
        "isProcessed": false,
        "isPending": true,
        "isArrived": false,
        "isActive": true,
        "fromLat": fromLat,
        "fromLng": fromLng,
        "toLat": toLat,
        "toLng": toLng,
        "userID": userId,
        "userName": userName,
        "userImage": userImage,
        "userPhoneNumber": userPhoneNumber,
        "vehicleIcon": vehicleIcon,
        "rejectedUsers": rejectedUsers == null
            ? []
            : List<dynamic>.from(rejectedUsers!.map((x) => x)),
        "vehicleType": vehicleType,
      };
}
