import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

import 'layout/body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: SizedBox(),
        title: CustomText(
          text: 'My Profile'.tr(),
          fontSize: 16,
          color: AppColors.primary,
        ),
        centerTitle: true,
      ),
      body: ProfileBody(),
    );
  }
}
