import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:riding_app/models/rider.dart';
import 'package:riding_app/models/rider_vehicle.dart';

class RiderServices {
  ///Create User
  Future<void> createRider(BuildContext context,
      {required RiderModel model, required String userID}) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('riderCollection').doc(userID);
    await docRef.set(model.toJson(docRef.id));
  }

  ///Add Rider Vehicle Details
  Future<void> addRiderVehicleDetails(BuildContext context,
      {required RiderVehicleModel model, required String userID}) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('riderCollection')
        .doc(userID)
        .collection('vehicleCollection')
        .doc();
    await docRef.set(model.toJson(docRef.id));
  }

  ///Stream All Riders
  ///Stream Rider By ID
  Stream<RiderModel> fetchUserData(String uid) {
    return FirebaseFirestore.instance
        .collection('riderCollection')
        .doc(uid)
        .snapshots()
        .map((event) => RiderModel.fromJson(event.data()!));
  }

  ///Fetch User Data
  Future<RiderModel> fetchUpdateRiderData(String uid) {
    return FirebaseFirestore.instance
        .collection('riderCollection')
        .doc(uid)
        .get()
        .then((event) => event.data() == null
            ? RiderModel()
            : RiderModel.fromJson(event.data()!));
  }

  ///Stream Rider Vehicle Details
  Stream<List<RiderVehicleModel>> streamRiderVehicle(String uid) {
    return FirebaseFirestore.instance
        .collection('riderCollection')
        .doc(uid)
        .collection('vehicleCollection')
        .snapshots()
        .map((event) => event.docs
            .map((e) => RiderVehicleModel.fromJson(e.data()))
            .toList());
  }

  ///Fetch Rider Vehicle Details
  Future<List<RiderModel>> fetchRiders(
      {required String vehicleType, required String cityID}) {
    return FirebaseFirestore.instance
        .collection('riderCollection')
        .where('isBusy', isEqualTo: false)
        .where('isOnline', isEqualTo: true)
        .where('vehicleTypeID', isEqualTo: vehicleType)
        .where('cityID', isEqualTo: cityID)
        .get()
        .then((event) =>
            event.docs.map((e) => RiderModel.fromJson(e.data())).toList());
  }

  ///Update User Data
  Future<void> updateUserData({required RiderModel model}) async {
    return await FirebaseFirestore.instance
        .collection('riderCollection')
        .doc(model.docId.toString())
        .update({
      "name": model.name.toString(),
      "image": model.image.toString(),
    });
  }

  ///Update Online Status
  Future<void> updateOnlineStatus({required RiderModel model}) async {
    return await FirebaseFirestore.instance
        .collection('riderCollection')
        .doc(model.docId.toString())
        .update({
      "isOnline": model.isOnline,
    });
  }

  ///Update IsBusy Status
  Future<void> updateBusyStatus({required RiderModel model}) async {
    if (model.docId != "")
      return await FirebaseFirestore.instance
          .collection('riderCollection')
          .doc(model.docId.toString())
          .update({
        "isBusy": model.isBusy,
        "rideID": model.rideID.toString(),
      });
  }

  ///Update Vehicle Type
  Future<void> updateVehicleType({required RiderModel model}) async {
    return await FirebaseFirestore.instance
        .collection('riderCollection')
        .doc(model.docId.toString())
        .update({
      "vehicleTypeID": model.vehicleTypeID.toString(),
    });
  }

  ///Update Location
  Future<void> updateLocation({required RiderModel model}) async {
    return await FirebaseFirestore.instance
        .collection('riderCollection')
        .doc(model.docId.toString())
        .update({
      "lat": model.lat,
      "lng": model.lng,
    });
  }
}
