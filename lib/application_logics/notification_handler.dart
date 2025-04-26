import '../controllers/notification.dart';

class NotificationHandler {
  NotificationServices _services = NotificationServices();

  ///Push 1-1 Notification
  oneToOneNotificationHelper(
      {required String docID, required String body, required String title}) {
    print("Admin ID : $docID");
    _services.streamSpecificUserToken(docID).then((value) {
      print("im called @ $value");
      _services.pushOneToOneNotification(
        sendTo: value,
        title: title,
        body: body,
      );
    });
  }
}
