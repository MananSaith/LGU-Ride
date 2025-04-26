import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

import 'layout/body.dart';

class TopUpView extends StatelessWidget {
  const TopUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customAppBar(context,showText:true,text:'Top up Wallet'.tr(),),
      body: TopUpBody(),
      // bottomNavigationBar:AppButton(onPressed: () {  }, btnLabel: 'Continue'.tr(),),
    );
  }
}
