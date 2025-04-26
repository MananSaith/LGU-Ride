import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class ChatServices {
  ///Create New Chat
  Future<void> createGroup(BuildContext context,
      {required GroupModel model}) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('groupChatCollection').doc(model.docId.toString());
    await docRef.set(model.toJson(docRef.id));
  }

  ///Stream Groups by Deal ID
  Stream<List<GroupModel>> streamGroupByDealID(
      {required String dealID, required String userID}) {
    print(userID);
    return FirebaseFirestore.instance
        .collection('groupChatCollection')
        .where('dealID', isEqualTo: dealID)
        .where('users', arrayContains: userID)
        .orderBy('createdAt')
        .snapshots()
        .map((event) {
      return event.docs.map((e) => GroupModel.fromJson(e.data())).toList();
    });
  }

  ///Send Message
  Future<void> sendMessage(BuildContext context,
      {required GroupMessageModel model, required String groupID}) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('groupChatCollection')
        .doc(groupID)
        .collection('messages')
        .doc();
    await docRef.set(model.toJson());
  }

  ///Fetch Group Messages
  Stream<List<GroupMessageModel>> streamGroupMessage(
      {required String groupID}) {
    return FirebaseFirestore.instance
        .collection('groupChatCollection')
        .doc(groupID)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .map((event) => event.docs
            .map((e) => GroupMessageModel.fromJson(e.data()))
            .toList());
  }

  ///Add New Members
  Future addNewMembers(
      {required String groupID, required List<String> userList}) async {
    return FirebaseFirestore.instance
        .collection('groupChatCollection')
        .doc(groupID)
        .update({
      'groupMember': FieldValue.arrayUnion([
        ...userList
            .map((e) =>
                GroupMemberModel(userId: e, time: Timestamp.now()).toJson())
            .toList()
      ]),
      'users': FieldValue.arrayUnion(userList)
    });
  }
}
