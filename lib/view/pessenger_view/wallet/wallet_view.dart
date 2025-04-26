import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


import 'layout/body.dart';

class WalletView extends StatelessWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.transparent,
        elevation:0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0,top:11,bottom:11,right:4),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color:AppColors.primary,),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset('assets/svg/car_icon.svg'),
            ),
          ),
        ),
        title:CustomText(text: 'My Wallet'.tr(),fontSize:16,color:AppColors.primary,),
        centerTitle:true,
      ),
      body:WalletBody(),
    );
  }
}
