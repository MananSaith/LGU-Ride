// To parse this JSON data, do
//
//     final ratingReviewsModel = ratingReviewsModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

RatingReviewsModel ratingReviewsModelFromJson(String str) =>
    RatingReviewsModel.fromJson(json.decode(str));

String ratingReviewsModelToJson(RatingReviewsModel data) => json.encode(
    data.toJson(docID: data.docId.toString(), uid: data.giveByID.toString()));

class RatingReviewsModel {
  RatingReviewsModel({
    this.docId,
    this.giveByID,
    this.giveByName,
    this.giveByImage,
    this.rating,
    this.review,
    this.time,
    this.giveToID,
    this.productID,
  });

  String? docId;
  String? giveByID;
  String? giveByName;
  String? giveByImage;
  num? rating;
  String? review;
  Timestamp? time;
  String? giveToID;
  String? productID;

  factory RatingReviewsModel.fromJson(Map<String, dynamic> json) =>
      RatingReviewsModel(
        docId: json["docID"],
        giveByID: json["giveByID"],
        rating: json["rating"],
        review: json["review"],
        time: json["time"],
        giveToID: json["giveToID"],
        giveByName: json["giveByName"],
        giveByImage: json["giveByImage"],
        productID: json["productID"],
      );

  Map<String, dynamic> toJson({required String docID, required String uid}) => {
        "docID": docID,
        "giveByID": uid,
        "rating": rating,
        "review": review,
        "time": Timestamp.fromDate(DateTime.now()),
        "giveToID": giveToID,
        "giveByName": giveByName,
        "giveByImage": giveByImage,
        "productID": productID,
      };
}
