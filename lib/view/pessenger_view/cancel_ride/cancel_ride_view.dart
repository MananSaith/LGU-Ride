import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

import 'layout/body.dart';

class CancelRideView extends StatelessWidget {
  final String rideID;
  final String riderID;
  final bool isRider;

  const CancelRideView(
      {Key? key,
      required this.rideID,
      required this.riderID,
      this.isRider = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, showText: true, text: 'Cancel Ride'.tr()),
      body: CancelRideBody(rideID: rideID, riderID: riderID, isRider: isRider),
    );
  }
}
