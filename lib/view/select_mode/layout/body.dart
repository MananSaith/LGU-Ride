

import 'package:riding_app/utils/app_imports.dart';
import 'package:flutter/material.dart';

class SelectModeBody extends StatelessWidget {
  const SelectModeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: MediaQuery.of(context).size.height,  
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/selection_bgg.jpg",
                    ),
                    fit: BoxFit.cover)),
            child: Container(
              // color: Colors.black.withOpacity(0.30),
              decoration: const BoxDecoration(),
            )),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                AppColors.primary.withValues(alpha: 0.05),
                AppColors.primary.withValues(alpha:0.5),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/app_logo.png",
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 8,
              ),
              RichText(
                  text: TextSpan(
                      text: "Welcome to".tr(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2,
                          fontSize: 16),
                      children: [
                    TextSpan(
                      text: "App".tr(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    )
                  ])),
              const SizedBox(
                height: 18,
              ),
              // CustomText(
              //   text: "The best taxi booking app of the century to make \nyour day great".tr(),
              //   color: Colors.white,
              // ),
              CustomText(
                text: "Now make your route easy for LGU with your Uni College ".tr(),
                color: Colors.white,
              ),
              context.locale.languageCode == "en"
                  ? CustomText(
                    text: "your day great".tr(),
                    color: Colors.white,
                  )
                  : SizedBox(),
              const SizedBox(
                height: 12,
              ),
              AppButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PassengerLogInView()));
                },
                color: Colors.white.withValues(alpha: 0.3),
                borderColor: Colors.white,
                btnLabel: "I’m a Passenger".tr(),
              ),
              const SizedBox(
                height: 18,
              ),
              AppButton(
                onPressed: () {


                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LogInViewDriver()));
                },
                color: Colors.white.withValues(alpha: 0.3),
                borderColor: Colors.white,
                btnLabel: "I’am a Driver".tr(),
              )
            ],
          ),
        )
      ],
    );
  }
}
