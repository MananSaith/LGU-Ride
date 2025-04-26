import 'package:flutter/material.dart';
import 'layout/body.dart';

class DriverArrivingView extends StatelessWidget {
  final String rideID;

  const DriverArrivingView({Key? key, required this.rideID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DriverArrivingBody(rideID: rideID);
  }
}
