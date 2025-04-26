// To parse this JSON data, do
//
//     final privacyPolicyModel = privacyPolicyModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';


class PrivacyPolicyModel {
  PrivacyPolicyModel({
    this.id,
    this.title,
    this.file,
    this.createdAt,
  });

  String? id;
  String? title;
  String? file;
  Timestamp? createdAt;

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) => PrivacyPolicyModel(
        id: json["docID"],
        title: json["title"],
        file: json["file"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "file": file,
        "created_at": createdAt,
      };
}
