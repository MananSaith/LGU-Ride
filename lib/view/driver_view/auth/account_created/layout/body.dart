import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';
class AccountCreatedBody extends StatelessWidget {
  const AccountCreatedBody({Key? key}) : super(key: key);

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
                  text: "Account Created".tr(),
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  letterSpacing:1.2,
                ),
              ],
            ),
            RichText(
                textAlign:TextAlign.center,
                text:  TextSpan(
                    text: "Your form has been submitted successfully. Approving \n".tr(),

                    style: TextStyle(
                        color:Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        height:1.5
                    ),
                    children:   [
                      TextSpan(
                          text: " process usually takes us about 3 - 5 days  but we will do\n ".tr(),
                          style: TextStyle(
                            color:Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            decoration:TextDecoration.none,
                          )),
                      TextSpan(
                          text: " our best to get back to you sooner.".tr(),
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
