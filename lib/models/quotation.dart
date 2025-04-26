// To parse this JSON data, do
//
//     final quotationModel = quotationModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

QuotationModel quotationModelFromJson(String str) =>
    QuotationModel.fromJson(json.decode(str));

class QuotationModel {
  String? docId;
  String? image;
  String? quotation;
  String? author;
  String? userID;
  List<String>? favUser;
  List<String>? pastUser;
  int? createdAt;

  QuotationModel({
    this.docId,
    this.image,
    this.quotation,
    this.favUser,
    this.createdAt,
    this.author,
    this.userID,
    this.pastUser,
  });

  factory QuotationModel.fromJson(Map<String, dynamic> json) => QuotationModel(
        docId: json["docID"],
        image: json["image"],
        quotation: json["quotation"],
        favUser: json["favUser"] == null
            ? []
            : List<String>.from(json["favUser"]!.map((x) => x)),
        pastUser: json["pastUser"] == null
            ? []
            : List<String>.from(json["pastUser"]!.map((x) => x)),
        createdAt: json["createdAt"],
        author: json["author"],
        userID: json["userID"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "docID": docID,
        "image": image,
        "quotation": quotation,
        "favUser":
            favUser == null ? [] : List<dynamic>.from(favUser!.map((x) => x)),
        "pastUser":
            pastUser == null ? [] : List<dynamic>.from(pastUser!.map((x) => x)),
        "createdAt": Timestamp.now().millisecondsSinceEpoch,
        "author": author,
        "userID": userID,
      };
}
