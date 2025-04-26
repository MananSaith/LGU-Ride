import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riding_app/models/vehicle.dart';

class VehicleServices {
  ///Stream Vehicles
  // Future<List<VehicleModel>> streamVehicles() async{
  //   // return FirebaseFirestore.instance
  //   //     .collection('vehicleCollection')
  //   //     .snapshots()
  //   //     .map((event) =>
  //   //         event.docs.map((e) => VehicleModel.fromJson(e.data())).toList());
  //
  //   print("======================================= Fetching Vehicles for ride...");
  //   try {
  //     QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('vehicleCollection')
  //         .get();
  //
  //     List<VehicleModel> vehicles = snapshot.docs
  //         .map((e) => VehicleModel.fromJson(e.data() as Map<String, dynamic>))
  //         .toList();
  //
  //     return vehicles;
  //   } catch (e) {
  //     print("================================== Error: $e");
  //     return [];
  //   }
  //
  //
  // }

 Stream<List<VehicleModel>> streamVehicles() {
    print("======================================= Streaming Vehicles for ride...");
    return FirebaseFirestore.instance
        .collection('vehicleCollection')
        .snapshots()
        .map((snapshot) {
      try {
        print("444444444444444444444444444444444");

        List<VehicleModel> vehicles = snapshot.docs
            .map((e) => VehicleModel.fromJson(e.data()))
            .toList();
print("=============== data ${vehicles[0].docId}");
        return vehicles;

      } catch (e) {
        print("================================== Error while parsing vehicles: $e");
        return <VehicleModel>[]; // Return empty list on error
      }
    });
  }


  ///Fetch Vehicles
  Future<List<VehicleModel>> fetchVehicles() async {
    print("======================================= Fetching Vehicles...");
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('vehicleCollection')
          .get();

      List<VehicleModel> vehicles = snapshot.docs
          .map((e) => VehicleModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();

      return vehicles;
    } catch (e) {
      print("================================== Error: $e");
      return [];
    }
  }
}
