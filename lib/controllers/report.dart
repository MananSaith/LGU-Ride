import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riding_app/models/report.dart';

class ReportServices {
  ///Create Report
  Future<String> createReport({required ReportModel model}) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('reportCollection').doc();
    await docRef.set(model.toJson(docRef.id));
    return docRef.id.toString();
  }
}
