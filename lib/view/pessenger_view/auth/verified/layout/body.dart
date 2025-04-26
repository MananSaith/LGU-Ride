import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class VerifiedBody extends StatelessWidget {
  const VerifiedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:18.0),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
          Image.asset("assets/images/vf.png"),
          const SizedBox(height:18,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "Verified Successfully".tr(),
                fontSize: 21,
                fontWeight: FontWeight.w600,
                letterSpacing:1.2,
              ),
            ],
          ),
          RichText(
            textAlign:TextAlign.center,
              text:  TextSpan(
                  text: "Your account has been verified successfully. You\n".tr(),
                  style: TextStyle(
                      color:Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    height:1.5
                  ),
                  children:   [
                    TextSpan(
                        text: " can now use our app to book the cabs".tr(),
                        style: TextStyle(
                            color:Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            decoration:TextDecoration.none,
                        )),
                    TextSpan(
                        text: " \nHave a great day!".tr(),
                        style: TextStyle(
                            color:Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            decoration:TextDecoration.none
                        ))

                  ])),

        ],),
      ),
    );
  }
}
