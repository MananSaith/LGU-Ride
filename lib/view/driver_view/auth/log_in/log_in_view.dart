import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';
import 'layout/body.dart';

class LogInViewDriver extends StatelessWidget {
  LogInViewDriver({Key? key, this.showBackButton = true})
      : super(key: key);

  bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return !showBackButton
        ? WillPopScope(
            onWillPop: () => Future.value(false),
            child: Scaffold(
              appBar: customAppBar(
                context,
                showBackButton: false
              ),
              body: DriverLogInBody(),
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
                                builder: (context) => const SignUpViewDriver()));
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
            appBar: customAppBar(
              context,
            ),
            body: DriverLogInBody(),
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
                              builder: (context) => const SignUpViewDriver()));
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
