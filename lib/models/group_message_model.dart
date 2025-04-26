// To parse this JSON data, do
//
//     final groupMessageModel = groupMessageModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

GroupMessageModel groupMessageModelFromJson(String str) =>
    GroupMessageModel.fromJson(json.decode(str));

String groupMessageModelToJson(GroupMessageModel data) =>
    json.encode(data.toJson());

class GroupMessageModel {
  GroupMessageModel({
    this.message,
    this.senderId,
    this.time,
    this.fileUrl,
    this.senderName,
    this.fileName,
    this.userImage,
  });

  String? message;
  String? senderId;
  String? senderName;
  String? fileUrl;
  String? fileName;
  String? userImage;
  Timestamp? time;

  factory GroupMessageModel.fromJson(Map<String, dynamic> json) =>
      GroupMessageModel(
        message: json["message"],
        senderId: json["senderID"],
        senderName: json["name"],
        time: json["time"],
        fileUrl: json["fileUrl"],
        fileName: json["fileName"],
        userImage: json["userImage"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "senderID": senderId,
        "name": senderName,
        "fileName": fileName,
        "fileUrl": fileUrl,
        "userImage": userImage,
        "time": Timestamp.fromDate(DateTime.now()),
      };
}
