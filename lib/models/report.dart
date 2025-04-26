// To parse this JSON data, do
//
//     final reportModel = reportModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ReportModel reportModelFromJson(String str) => ReportModel.fromJson(json.decode(str));


class ReportModel {
  final String? docId;
  final String? reason;
  final String? rideId;
  final String? riderId;
  final String? userId;
  final int? createdAt;

  ReportModel({
    this.docId,
    this.reason,
    this.rideId,
    this.riderId,
    this.userId,
    this.createdAt,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
    docId: json["docID"],
    reason: json["reason"],
    rideId: json["rideID"],
    riderId: json["riderID"],
    userId: json["userID"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String docID) => {
    "docID": docID,
    "reason": reason,
    "rideID": rideId,
    "riderID": riderId,
    "userID": userId,
    "createdAt": Timestamp.now().millisecondsSinceEpoch,
  };
}
