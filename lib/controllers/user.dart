import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:riding_app/models/rider.dart';

import '../models/user.dart';

class UserServices {
  ///Create User
  Future<void> createUser(BuildContext context,
      {required RiderModel model, required String userID}) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('riderCollection').doc(userID);
    await docRef.set(model.toJson(docRef.id));
  }

  ///Fetch User Data
  Stream<RiderModel> fetchUserData(String uid) {
    return FirebaseFirestore.instance
        .collection('riderCollection')
        .doc(uid)
        .snapshots()
        .map((event) => RiderModel.fromJson(event.data()!));
  }

  ///Fetch User Data
  Future<RiderModel> fetchUpdatedData(String uid) {
    return FirebaseFirestore.instance
        .collection('riderCollection')
        .doc(uid)
        .get()
        .then((event) => event.data() == null
            ? RiderModel()
            : RiderModel.fromJson(event.data()!));
  }

  ///Fetch User By ID
  Future<List<RiderModel>> fetchUserByID(String userID) {
    log(userID);
    return FirebaseFirestore.instance
        .collection('riderCollection')
        .where("docID", isEqualTo: userID)
        .get()
        .then((event) =>
            event.docs.map((e) => RiderModel.fromJson(e.data())).toList());
  }

  ///Fetch All User
  Stream<List<RiderModel>> streamAlUsers() {
    return FirebaseFirestore.instance
        .collection('riderCollection')
        .snapshots()
        .map((event) =>
            event.docs.map((e) => RiderModel.fromJson(e.data())).toList());
  }

  ///Fetch Users
  Stream<List<RiderModel>> streamUsers(String userID) {
    return FirebaseFirestore.instance
        .collection('riderCollection')
        .where('docID', isNotEqualTo: userID)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => RiderModel.fromJson(e.data())).toList());
  }

  ///Fetch Users
  Stream<List<RiderModel>> streamUsersForDeals(String dealID) {
    return FirebaseFirestore.instance
        .collection('riderCollection')
        .where('dealIDs', arrayContains: dealID)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => RiderModel.fromJson(e.data())).toList());
  }

  ///Update User Data
  Future<void> updateUserData({required RiderModel model}) async {
    return await FirebaseFirestore.instance
        .collection('riderCollection')
        .doc(model.docId.toString())
        .update({
      "name": model.name.toString(),
      "phoneNumber": model.phoneNumber.toString(),
      "image": model.image.toString(),
    });
  }
  ///Update Location
  Future updateLocation({required RiderModel model}) async {
    return await FirebaseFirestore.instance
        .collection('riderCollection')
        .doc(model.docId.toString())
        .update({
      "lat": model.lat,
      "lng": model.lng,
    });
  }
}
