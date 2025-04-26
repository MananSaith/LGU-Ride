// To parse this JSON data, do
//
//     final contactUsModel = contactUsModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ContactUsModel contactUsModelFromJson(String str) => ContactUsModel.fromJson(json.decode(str));


class ContactUsModel {
  String? docId;
  String? name;
  String? email;
  String? phoneNumber;
  String? subject;
  String? description;
  int? createdAt;

  ContactUsModel({
    this.docId,
    this.name,
    this.email,
    this.phoneNumber,
    this.subject,
    this.description,
    this.createdAt,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
    docId: json["docID"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    subject: json["subject"],
    description: json["description"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String docID) => {
    "docID": docID,
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
    "subject": subject,
    "description": description,
    "createdAt": Timestamp.now(),
  };
}
