import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

Future<void> rideArrivedDialog(context, RideModel model) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
          insetPadding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/svg/dialogue_cover.svg"),
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Arrived!".tr(),
                    style: AppColors.kHeadingStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              context.locale.languageCode=="en" ?
              Column(
                children: [
                  CustomText(
                      text:
                          "You have arrived  at your destination, ".tr()),
                  CustomText(
                      text:
                      "see you on the next trip :) ".tr()),
                ],
              ) : CustomText(
                  text:
                  "You have arrived  at your destination, see you on the next trip :) ".tr()),
              const SizedBox(
                height: 18,
              ),
              AppButton(
                  onPressed: () {
                    showRatingSheet(context, model);
                  },
                  btnLabel: 'Ok'.tr())
            ],
          ));
    },
  );
}
