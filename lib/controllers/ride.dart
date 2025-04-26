
import 'package:riding_app/utils/app_imports.dart';
import 'package:http/http.dart' as http;


class RideServices {

  ///Create Ride
  Future<String> createRide({required RideModel model}) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('rideCollection').doc();
    await docRef.set(model.toJson(docRef.id));
    return docRef.id.toString();
  }

  ///Stream Ride By ID
  Stream<RideModel> streamRideByID(String uid) {
    return FirebaseFirestore.instance
        .collection('rideCollection')
        .doc(uid)
        .snapshots()
        .map((event) => RideModel.fromJson(event.data()!));
   
  }

  ///Stream Ride By ID
  Future<RideModel> getRideByID(String uid) {
    return FirebaseFirestore.instance
        .collection('rideCollection')
        .doc(uid)
        .get()
        .then((event) => RideModel.fromJson(event.data()!));
  }

  ///Stream My Rides
  Stream<List<RideModel>> streamCompletedRides(String userID) {
    return FirebaseFirestore.instance
        .collection('rideCollection')
        .where('userID', isEqualTo: userID)
        .where('isCompleted', isEqualTo: true)
        .where('isPending', isEqualTo: false)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => RideModel.fromJson(e.data())).toList());
  }

  ///Get My Rides
  Future<List<RideModel>> getMyRides(String userID) {
    return FirebaseFirestore.instance
        .collection('rideCollection')
        .where('userID', isEqualTo: userID)
        .where('isActive', isEqualTo: true)
        .get()
        .then((event) =>
            event.docs.map((e) => RideModel.fromJson(e.data())).toList());
  }

  ///Stream My Rides
  Stream<List<RideModel>> streamCancelledRides(String userID) {
    return FirebaseFirestore.instance
        .collection('rideCollection')
        .where('userID', isEqualTo: userID)
        .where('isCancelled', isEqualTo: true)
        .where('isPending', isEqualTo: false)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => RideModel.fromJson(e.data())).toList());
  }

  ///Stream Rider Rides
  Stream<List<RideModel>> streamRiderCancelledRides(String userID) {
    return FirebaseFirestore.instance
        .collection('rideCollection')
        .where('riderID', isEqualTo: userID)
        .where('isCancelled', isEqualTo: true)
        .where('isPending', isEqualTo: false)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => RideModel.fromJson(e.data())).toList());
  }

  ///Stream Rider Rides
  Stream<List<RideModel>> streamRiderCompletedRides(String userID) {
    return FirebaseFirestore.instance
        .collection('rideCollection')
        .where('riderID', isEqualTo: userID)
        .where('isCompleted', isEqualTo: true)
        .where('isPending', isEqualTo: false)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => RideModel.fromJson(e.data())).toList());
  }

  ///Stream Riders Rides
  Stream<List<RideModel>> streamRiderRides(String userID) {
    return FirebaseFirestore.instance
        .collection('rideCollection')
        .where('riderID', isEqualTo: userID)
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => RideModel.fromJson(e.data())).toList());
  }

  ///Stream Active Rides
  Stream<List<RideModel>> streamActiveRides(String userID) {
    return FirebaseFirestore.instance
        .collection('rideCollection')
        .where('isPending', isEqualTo: true)
        //.where('riders', arrayContains: userID)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => RideModel.fromJson(e.data())).toList());
  }

  ///Cancel Ride
  Future<void> cancelRide(
      {required String userID,
      required String rideID,
      required String reason,
      required String riderID}) async {
    await FirebaseFirestore.instance
        .collection('rideCollection')
        .doc(rideID)
        .update({"isCancelled": true, 'isPending': false, 'isActive': false});
    await ReportServices().createReport(
        model: ReportModel(
            reason: reason, userId: userID, rideId: rideID, riderId: riderID));
  }

  ///Send Ride
  Future sendRide({required String rideID, required String driverID}) async {
    return await FirebaseFirestore.instance
        .collection('rideCollection')
        .doc(rideID)
        .update({
      'riders': FieldValue.arrayUnion([driverID]),
    });
  }

  ///Accept Ride
  Future acceptRide({required String rideID, required RiderModel model}) async {
    return await FirebaseFirestore.instance
        .collection('rideCollection')
        .doc(rideID)
        .update({
      'isPending': false,
      'riderID': model.docId.toString(),
      'riderName': model.name.toString(),
      'riderImage': model.image.toString(),
      'riderPhoneNumber': model.phoneNumber.toString(),
      'isProcessed': true,
    });
  }

  ///Reject Ride
  Future rejectRide({required String rideID, required RiderModel model}) async {
    return await FirebaseFirestore.instance
        .collection('rideCollection')
        .doc(rideID)
        .update({
      'rejectedUsers': FieldValue.arrayUnion([model.docId.toString()]),
    });
  }

  ///Finish Ride
  Future finishRide({required String rideID, required RideModel model}) async {
    await FirebaseFirestore.instance
        .collection('rideCollection')
        .doc(rideID)
        .update({
      'isCompleted': true,
      'isActive': false,
    });
    NotificationHandler().oneToOneNotificationHelper(
        docID: model.userId.toString(),
        body: 'Your ride has been completed.',
        title: "Ride Update!");
  }

  ///Start Ride
  Future startRide({required String rideID, required RideModel model}) async {
    await FirebaseFirestore.instance
        .collection('rideCollection')
        .doc(rideID)
        .update({
      'isArrived': true,
    });
    NotificationHandler().oneToOneNotificationHelper(
        docID: model.userId.toString(),
        body: 'Your ride has been started.',
        title: "Ride Update!");
  }


  //"error_message" : "You must enable Billing on the Google Cloud Project at
  Future<String> calculateTime({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
  }) async {
    String time = "N/A";

    try {
      final response = await http.get(
        Uri.parse(
          'https://maps.googleapis.com/maps/api/directions/json?origin=$startLat,$startLng&destination=$endLat,$endLng&key=${BackendConfigs.kMapKey}',
        ),
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final routes = data['routes'];
        if (routes != null && routes.isNotEmpty) {
          final legs = routes[0]['legs'];
          if (legs != null && legs.isNotEmpty) {
            final durationText = legs[0]['duration']['text'];
            time = durationText;
          } else {
            print("No legs found.");
          }
        } else {
          print("No routes found.");
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching duration: $e");
    }

    return time;
  }


}
