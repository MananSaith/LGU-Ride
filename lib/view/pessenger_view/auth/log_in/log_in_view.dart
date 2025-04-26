import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';
import 'package:riding_app/view/pessenger_view/auth/sign_up/sign_up_view.dart';
import 'layout/body.dart';

class PassengerLogInView extends StatelessWidget {
  PassengerLogInView({Key? key, this.showBackButton = true}) : super(key: key);

  bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return !showBackButton
        ? WillPopScope(
            onWillPop: () => Future.value(false),
            child: Scaffold(
              backgroundColor: AppColors.gray200,
              appBar: customAppBar(context, showBackButton: false),
              body: LogInBody(),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpViewPassenger()));
                      },
                      child: RichText(
                          text: TextSpan(
                              text: "Don’t have an account? ".tr(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                              children: [
                            TextSpan(
                              text: " Sign up.".tr(),
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            )
                          ])),
                    )
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: customAppBar(context),
            body: LogInBody(),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpViewPassenger()));
                    },
                    child: RichText(
                        text: TextSpan(
                            text: "Don’t have an account? ".tr(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                            children: [
                          TextSpan(
                            text: " Sign up.".tr(),
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          )
                        ])),
                  )
                ],
              ),
            ),
          );
  }
}
