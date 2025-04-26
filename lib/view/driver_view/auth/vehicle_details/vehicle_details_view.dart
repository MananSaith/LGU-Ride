import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../configuration/frontend_configs.dart';
import 'layout/body.dart';

class VehicleDetailsView extends StatelessWidget {
  const VehicleDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Vehicle Details".tr(),
          style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: VehicleDetailsViewBody(),
    );
  }
}
