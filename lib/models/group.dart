// To parse this JSON data, do
//
//     final groupModel = groupModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

GroupModel groupModelFromJson(String str) =>
    GroupModel.fromJson(json.decode(str));

class GroupModel {
  String? docId;
  String? dealId;
  String? lastMessage;
  String? name;
  List<GroupMemberModel>? groupMember;
  List<String>? users;
  int? createdAt;

  GroupModel({
    this.docId,
    this.dealId,
    this.lastMessage,
    this.name,
    this.groupMember,
    this.users,
    this.createdAt,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        docId: json["docID"],
        dealId: json["dealID"],
        lastMessage: json["lastMessage"],
        name: json["name"],
        users: json["users"] == null
            ? []
            : List<String>.from(json["users"]!.map((x) => x)),
        groupMember: json["groupMember"] == null
            ? []
            : List<GroupMemberModel>.from(
                json["groupMember"]!.map((x) => GroupMemberModel.fromJson(x))),
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "docID": docID,
        "dealID": dealId,
        "lastMessage": lastMessage,
        "name": name,
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x)),
        "groupMember": groupMember == null
            ? []
            : List<dynamic>.from(groupMember!.map((x) => x.toJson())),
        "createdAt": DateTime.now().millisecondsSinceEpoch,
      };
}

GroupMemberModel groupMemberModelFromJson(String str) =>
    GroupMemberModel.fromJson(json.decode(str));

String groupMemberModelToJson(GroupMemberModel data) =>
    json.encode(data.toJson());

class GroupMemberModel {
  String? userId;
  Timestamp? time;

  GroupMemberModel({
    this.userId,
    this.time,
  });

  factory GroupMemberModel.fromJson(Map<String, dynamic> json) =>
      GroupMemberModel(
        userId: json["userID"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "userID": userId,
        "time": time,
      };
}
