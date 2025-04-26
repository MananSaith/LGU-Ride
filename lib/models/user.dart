// // To parse this JSON data, do
// //
// //     final userModel = userModelFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
//
// String userModelToJson(UserModel data) =>
//     json.encode(data.toJson(data.docId.toString()));
//
// class UserModesl {
//   String? docId;
//   int? createdAt;
//   String? name;
//   String? email;
//   String? userId;
//   String? phoneNumber;
//   String? cityID;
//   String? image;
//   double? lat;
//   double? lng;
//
//
//   UserModesl({
//     this.docId,
//     this.createdAt,
//     this.name,
//     this.email,
//     this.userId,
//     this.phoneNumber,
//     this.cityID,
//     this.image,
//     this.lat,
//     this.lng,
//   });
//
//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         docId: json["docID"],
//         createdAt: json["createdAt"],
//         name: json["name"],
//         email: json["email"],
//         userId: json["userID"],
//         image: json["image"],
//     phoneNumber: json["phoneNumber"],
//     cityID: json["cityID"],
//     lng: json["lng"],
//     lat: json["lat"],
//       );
//
//   Map<String, dynamic> toJson(String docID) => {
//         "docID": docID,
//         "createdAt": Timestamp.now().millisecondsSinceEpoch,
//         "name": name,
//         "email": email,
//         "userID": userId,
//         "image": image,
//         "phoneNumber": phoneNumber,
//         "cityID": cityID,
//         "lng": lng,
//         "lat": lat,
//       };
// }
