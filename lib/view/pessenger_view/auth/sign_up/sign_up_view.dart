import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';
import 'layout/body.dart';
class SignUpViewPassenger extends StatelessWidget {
  const SignUpViewPassenger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customAppBar(context,),
      body: SignUpBody(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom:10.0),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            TextButton(onPressed:(){
              Navigator.pop(context);
            }, child:RichText(
                text:  TextSpan(
                    text: "Already have an account? ".tr(),
                    style: TextStyle(
                        color:Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                    children: [
                      TextSpan(
                        text: " Sign in.".tr(),
                        style: TextStyle(
                            color:AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      )
                    ])),)
          ],
        ),
      ),
    );
  }
}
