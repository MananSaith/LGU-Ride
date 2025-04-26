import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

import 'layout/body.dart';
class VerifyNumberView extends StatelessWidget {
  const VerifyNumberView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:customAppBar(context),
      body:const VerifyNumberBody(),
    );
  }
}
