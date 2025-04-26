import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';
import 'layout/body.dart';

class TripDetailsView extends StatelessWidget {
  const TripDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customAppBar(context,showText:true,text:'Trip Detail'.tr()),
      body:TripDetailsBody(),
    );
  }
}
