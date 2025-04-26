import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';
import 'layout/body.dart';

class DriverForgotPasswordView extends StatelessWidget {
  const DriverForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
      ),
      body: ForgotPasswordViewBody(),
    );
  }
}
