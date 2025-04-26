import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../configuration/frontend_configs.dart';
import 'layout/body.dart';

class PassengerHistoryView extends StatelessWidget {
  const PassengerHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: SizedBox(),
          title: Text(
            "Trip History".tr(),
            style: TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,

        ),
        body: const PassengerHistoryBody(),
      ),
    );
  }
}
