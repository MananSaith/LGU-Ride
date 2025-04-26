import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:riding_app/application_logics/error_string.dart';
import 'package:riding_app/application_logics/user_provider.dart';
import 'package:riding_app/models/rider.dart';
import 'package:riding_app/controllers/rider.dart';
import 'package:riding_app/widgets/navigation_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../configuration/enums.dart';
import '../models/user.dart';
import '../controllers/auth.dart';
import '../controllers/user.dart';

class LoginBusinessLogic {
  UserServices _userServices = UserServices();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<RiderModel> loginUserLogic(BuildContext context,
      {required String email, required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var login = Provider.of<AuthServices>(context, listen: false);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var auth = Provider.of<AuthServices>(context, listen: false);
    RiderModel? model;
    var error = Provider.of<ErrorString>(context, listen: false);
    return login
        .signIn(context, email: email, password: password)
        .then((User? user) async {
      if (user != null) {
        if (user.emailVerified == true) {
          return await _userServices
              .fetchUpdatedData(user.uid)
              .then((event) async {
            if (event.docId != null) {
              userProvider.saveUserDetails(event);

              prefs.setString("USER_DATA", riderModelToJson(event));
              prefs.setString("TYPE", "USER");
              prefs.setBool("SHOW_USER_BIOMETRIC", true);
              auth.setState(Status.Authenticated);
              return event;
            } else {
              auth.setState(Status.Unauthenticated);
              error.saveErrorString(
                  'It seems provided email or password is invalid.'.tr());
              return event;
            }
          });
        } else {
          AuthServices.instance().signOut();
          Provider.of<ErrorString>(context, listen: false).saveErrorString(
              'Kindly activate your email address to proceed login.'.tr());
          auth.setState(Status.Unauthenticated);
          return RiderModel();
        }
      } else {
        return RiderModel();
      }
    });
  }

  Future<RiderModel> loginDriverLogic(BuildContext context,
      {required String email, required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var login = Provider.of<AuthServices>(context, listen: false);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var auth = Provider.of<AuthServices>(context, listen: false);
    var error = Provider.of<ErrorString>(context, listen: false);
    RiderModel? model;
    return login
        .signIn(context, email: email, password: password)
        .then((User? user) async {
      if (user != null) {
        if (user.emailVerified == true) {
          return await RiderServices()
              .fetchUpdateRiderData(user.uid)
              .then((event) async {
            if (event.docId != null) {
              if (event.vehicleTypeID != null) {
                if (event.isApproved != true) {
                  auth.setState(Status.Unauthenticated);
                  error.saveErrorString(
                      'Sorry! Your account is still under approval.'.tr());
                } else if (event.isBlocked != false) {
                  auth.setState(Status.Unauthenticated);
                  error.saveErrorString(
                      'Sorry! Your account has been blocked by admin.'.tr());
                } else {
                  userProvider.saveRiderData(event);

                  prefs.setString("USER_DATA", riderModelToJson(event));
                  prefs.setString("TYPE", "RIDER");
                  auth.setState(Status.Authenticated);
                }
              } else {
                userProvider.saveRiderData(event);

                prefs.setString("USER_DATA", riderModelToJson(event));
                prefs.setString("TYPE", "RIDER");
                auth.setState(Status.Authenticated);
              }
              return event;
            } else {
              auth.setState(Status.Unauthenticated);
              error.saveErrorString(
                  'It seems provided email or password is invalid.'.tr());
              return event;
            }
          });
        } else {
          AuthServices.instance().signOut();
          Provider.of<ErrorString>(context, listen: false).saveErrorString(
              'Kindly activate your email address to proceed login.'.tr());
          auth.setState(Status.Unauthenticated);
          return RiderModel();
        }
      } else {
        return RiderModel();
      }
    });
  }
}
