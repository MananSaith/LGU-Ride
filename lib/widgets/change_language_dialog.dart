import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showChangeLanguageDialog(BuildContext context) async {
  showDialog(
    barrierDismissible: false,
      context: (context),
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Change Language".tr()),
          // content: Text("You can change language here".tr()),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("English".tr()),
              onPressed: () {
                context.setLocale(const Locale('en'));
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              onPressed: () {
                context.setLocale(const Locale('ur'));
                Navigator.pop(context);
              },
              child: Text("Urdu".tr()),
            ),
            // CupertinoDialogAction(
            //   onPressed: () {
            //     context.setLocale(const Locale('ar'));
            //     Navigator.pop(context);
            //   },
            //   child: Text("Pashto".tr()),
            // ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel".tr(), style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      });
}
