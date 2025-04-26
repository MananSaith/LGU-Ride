import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riding_app/models/city.dart';

class CityServices {
  ///Stream All Cities
  Future<List<CityModel>> fetchCities() {


    // return FirebaseFirestore.instance
    //     .collection('cityCollection')
    //     .get()
    //     .then((event) =>
    //         event.docs.map((e) => CityModel.fromJson(e.data())).toList());
    return Future.value([
      CityModel(name: "Lahore", docId: "5"),
    ]);
  }

}
