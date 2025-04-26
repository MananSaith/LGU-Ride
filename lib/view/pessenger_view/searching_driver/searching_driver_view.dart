import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

import 'layout/body.dart';

class SearchingDriverView extends StatelessWidget {
  final String rideID;
  final String vehicleID;
  final String vehicleImage;

  const SearchingDriverView(
      {super.key,
      required this.rideID,
      required this.vehicleID,
      required this.vehicleImage});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CancelRideView(
                      rideID: rideID,
                      riderID: "",
                    )));
        return Future.value(true);
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SearchingDrivingBody(
          rideID: rideID,
          vehicleID: vehicleID,
          vehicleImage: vehicleImage,
        ),
      ),
    );
  }
}
