import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../configuration/backend_configs.dart';

class NotificationServices {
  ///Push 1-1 Notification
  Future pushOneToOneNotification({
    required String title,
    required String body,
    required String sendTo,
  }) async {
    print("I am sending to : $sendTo");
    return await http
        .post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "key=${BackendConfigs.kServerKey}"
            },
            body: json.encode({
              "data": {"body": body, "title": title, "sound": "default"},
              "android": {"priority": "high"},
              "apns": {
                "payload": {
                  "aps": {"sound": "default"}
                }
              },
              "to": sendTo
            }))
        .then((value) => print(value.body));
  }

  //
  Future pushBroadCastNotification({
    required String title,
    required String body,
    required String department,
  }) async {
    String toParams = "/topics/" + department;
    return await http
        .post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "key=${BackendConfigs.kServerKey}"
            },
            body: json.encode({
              "data": {"body": body, "title": title, "sound": "default"},
              "android": {"priority": "high"},
              "content_available": true,
              "apn-priority": 5,
              "apns": {
                "payload": {
                  "aps": {"sound": "default"}
                }
              },
              "to": "$toParams"
            }))
        .then((value) {
      print("Body: ${value.body}");
      print(value.statusCode);
    }).catchError((e) {
      print(e.toString());
    });
  }

  ///Get One Specific User Token
  Future<String> streamSpecificUserToken(String docID) {

    return FirebaseFirestore.instance
        .collection('deviceTokens')
        .doc(docID)
        .get()
        .then((event) {
      return event.data()!['deviceTokens'];
    });
  }
}
