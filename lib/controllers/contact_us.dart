import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/contact_us.dart';

class ContactUsServices {
  Future addQuery(ContactUsModel model) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('contactUsCollection').doc();
    await docRef.set(model.toJson(docRef.id));
  }
}
