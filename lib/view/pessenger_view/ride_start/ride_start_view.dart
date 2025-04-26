import 'package:flutter/material.dart';
import 'layout/body.dart';

class RideStartView extends StatelessWidget {
  final String rideID;

  const RideStartView({super.key, required this.rideID});

  @override
  Widget build(BuildContext context) {
    return RideStartBody(
      rideID: rideID,
    );
  }
}
