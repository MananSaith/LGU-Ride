import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/privacy_policy.dart';

class TermsAndConditionServices {
  ///Stream All Terms and Conditions
  Stream<List<PrivacyPolicyModel>> streamTermsAndConditions(
      BuildContext context) {
    return FirebaseFirestore.instance
        .collection('termsAndConditionCollection')
        .snapshots()
        .map((event) => event.docs.map((e) {
              log(e.data().toString());
              return PrivacyPolicyModel.fromJson(e.data());
            }).toList());
  }
}
