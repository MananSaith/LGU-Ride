import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riding_app/application_logics/upload_file_services.dart';
import 'package:riding_app/application_logics/user_provider.dart';
import 'package:riding_app/models/rider.dart';
import 'package:riding_app/controllers/rider.dart';

import '../models/user.dart';
import '../controllers/auth.dart';
import '../controllers/user.dart';

enum SignUpStatus { Initial, Registered, Registering, Failed }

enum ValidatedStatus { Validated, NotValidated }

class SignUpBusinessLogic with ChangeNotifier {
  SignUpStatus _status = SignUpStatus.Initial;
  ValidatedStatus _vStatus = ValidatedStatus.NotValidated;

  SignUpStatus get status => _status;

  void setState(SignUpStatus status) {
    _status = status;
    notifyListeners();
  }

  AuthServices _authServices = AuthServices.instance();

  UserServices _userServices = UserServices();

  Future<void> _initFcm() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseMessaging.instance.getToken().then((token) {
      print(token);
      FirebaseFirestore.instance.collection('deviceTokens').doc(uid).set(
        {
          'deviceTokens': token,
        },
      );
    });
  }

  ///Register new user and Add its details in Firestore
  Future registerNewUser(
      {required String email,
      required String password,
      required RiderModel userModel,
      required BuildContext context}) async {
    _status = SignUpStatus.Registering;
    notifyListeners();
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    return _authServices
        .signUp(
      context,
      email: email,
      password: password,
    )
        .then((User? user) async {
      if (user != null) {
        setState(SignUpStatus.Registered);

        return await _userServices
            .createUser(context, model: userModel, userID: user.uid)
            .then((value) async {
          await UserServices()
              .fetchUpdatedData(user.uid.toString())
              .then((value) {
            userProvider.saveUserDetails(value);
            _initFcm();
            setState(SignUpStatus.Registered);
          });
        });
      } else {
        setState(SignUpStatus.Failed);
      }
    });
  }

  ///Register new user and Add its details in Firestore
  Future registerNewRider(
      {required String email,
      required String password,
      required RiderModel userModel,
      required File? cnciFront,
      required File? cnicBack,
      required BuildContext context}) async {
    _status = SignUpStatus.Registering;
    notifyListeners();
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    return _authServices
        .signUp(
      context,
      email: email,
      password: password,
    )
        .then((User? user) async {
      if (user != null) {
        setState(SignUpStatus.Registered);
        await UploadFileServices()
            .getUrl(context, cnciFront)
            .then((front) async {
          await UploadFileServices()
              .getUrl(context, cnicBack)
              .then((back) async {
            return await RiderServices()
                .createRider(context,
                    model: RiderModel(
                      cnicBack: back,
                      cnicFront: front,
                      email: email,
                      name: userModel.name.toString(),
                      isOnline: false,
                      isApproved: false,
                      isBlocked: false,
                      isBusy: false,
                      cityID: userModel.cityID.toString(),
                      cityName: userModel.cityName.toString(),
                      cnic: userModel.cnic.toString(),
                      phoneNumber: userModel.phoneNumber.toString(),
                    ),
                    userID: user.uid)
                .then((value) async {
              await RiderServices()
                  .fetchUpdateRiderData(user.uid.toString())
                  .then((value) {
                userProvider.saveRiderData(value);
                _initFcm();
                setState(SignUpStatus.Registered);
              });
            });
          });
        });
      } else {
        setState(SignUpStatus.Failed);
      }
    });
  }
}
