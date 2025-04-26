import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/privacy_policy.dart';

class PrivacyPolicyServices {
  ///Stream All Privacy Policy
  Stream<List<PrivacyPolicyModel>> streamPrivacyPolicy(BuildContext context) {
    return FirebaseFirestore.instance
        .collection('privacyPolicyCollection')
        .snapshots()
        .map((event) => event.docs
            .map((e) => PrivacyPolicyModel.fromJson(e.data()))
            .toList());
  }
}
