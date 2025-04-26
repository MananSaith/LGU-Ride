
import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class RatingReviewServices {
  ///Stream My Reviews
  Stream<List<RatingReviewsModel>> streamMyReviews(String userID) {

    return FirebaseFirestore.instance
        .collection('ratingReviewCollection')
        .where('giveToID',
            isEqualTo: userID)
        .snapshots()
        .map((event) => event.docs
            .map((e) => RatingReviewsModel.fromJson(e.data()))
            .toList());
  }

  ///Stream My UnSeen Reviews
  Stream<List<RatingReviewsModel>> streamMyUnseen(BuildContext context) {
    UserProvider expertUserModel = Provider.of<UserProvider>(context);
    print(expertUserModel.getUserDetails()!.docId.toString());
    return FirebaseFirestore.instance
        .collection('ratingReviewCollection')
        .where('giveToID',
            isEqualTo: expertUserModel.getUserDetails()!.docId.toString())
        .where('isSeen', isEqualTo: false)
        .snapshots()
        .map((event) => event.docs
            .map((e) => RatingReviewsModel.fromJson(e.data()))
            .toList());
  }

  ///Mark Review as Seen
  Future<void> updateRating(String docID) async {
    return FirebaseFirestore.instance
        .collection('ratingReviewCollection')
        .doc(docID)
        .update({'isSeen': true});
  }

  ///Stream My Reviews
  Stream<List<RatingReviewsModel>> streamOtherUserReview(String userID) {
    return FirebaseFirestore.instance
        .collection('ratingReviewCollection')
        .where('giveToID', isEqualTo: userID)
        .snapshots()
        .map((event) => event.docs
            .map((e) => RatingReviewsModel.fromJson(e.data()))
            .toList());
  }

  Future<void> addRating(
      {required RatingReviewsModel model, required String userID}) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('ratingReviewCollection').doc();
    await docRef.set(model.toJson(uid: userID, docID: docRef.id));
  }

  ///Check If User Already Rated for Current Order
  Stream<List<RatingReviewsModel>> checkIfUserAlreadyRated(
      {required String productID, required String userID}) {
    return FirebaseFirestore.instance
        .collection('ratingReviewCollection')
        .where('productID', isEqualTo: productID)
        .where('giveByID', isEqualTo: userID)
        .snapshots()
        .map((event) => event.docs
            .map((e) => RatingReviewsModel.fromJson(e.data()))
            .toList());
  }
}
