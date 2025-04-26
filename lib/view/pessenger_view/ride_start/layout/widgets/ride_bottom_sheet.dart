import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


Future<void> showRatingSheet(context) {
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 18,
              ),
              Container(
                height: 3,
                width: 36,
                decoration: BoxDecoration(
                  color: const Color(0xffE0E0E0),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              CustomText(
                text: 'Arrived at the destination'.tr(),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              const SizedBox(
                height: 8,
              ),
              Divider(
                color: AppColors.contentDisabled,
              ),
              const SizedBox(
                height: 8,
              ),
              ProfileWidget(
                model: RideModel(),
                onTapped: () {},
              ),
              const SizedBox(
                height: 8,
              ),
              Divider(
                color: AppColors.contentDisabled,
              ),
              CustomText(
                text: 'How was your trip with the driver?'.tr(),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 8,
              ),
              CustomText(
                text: 'Rate accordingly'.tr(),
                color: AppColors.contentDisabled,
              ),
              const SizedBox(
                height: 8,
              ),
              RatingBar.builder(
                initialRating: 3,
                glowColor: Colors.amberAccent,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/svg/rating_star.svg',
                    height: 28,
                    width: 28,
                  ),
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xff252525).withOpacity(0.15)),
                      child: Center(
                        child: CustomText(
                          text: 'Cancel'.tr(),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showTipSheet(context);
                    },
                    child: Container(
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.primary,
                      ),
                      child: Center(
                          child: CustomText(
                        text: 'Submit'.tr(),
                        color: Colors.white,
                      )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      });
}

Future<void> showTipSheet(context) {
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 18,
              ),
              Container(
                height: 3,
                width: 36,
                decoration: BoxDecoration(
                  color: const Color(0xffE0E0E0),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              CustomText(
                text: 'Add Tip'.tr(),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              const SizedBox(
                height: 8,
              ),
              Divider(
                color: AppColors.contentDisabled,
              ),
              const SizedBox(
                height: 8,
              ),
              ProfileWidget(
                model: RideModel(),
                onTapped: () {},
              ),
              const SizedBox(
                height: 8,
              ),
              Divider(
                color: AppColors.contentDisabled,
              ),
              const SizedBox(
                height: 8,
              ),
              CustomText(
                text: 'Do you want to add Tip?'.tr(),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RiderTip(amount: '\$5'.tr(), color: AppColors.kAuthColor),
                  RiderTip(amount: '\$10'.tr(), color: AppColors.kAuthColor),
                  RiderTip(amount: '\$15'.tr(), color: AppColors.kAuthColor),
                  RiderTip(amount: '\$20'.tr(), color: AppColors.kAuthColor),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xff252525).withOpacity(0.15)),
                      child: Center(
                        child: CustomText(
                          text: 'No Thanks'.tr(),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.primary,
                      ),
                      child: Center(
                          child: CustomText(
                        text: 'Pay Tip'.tr(),
                        color: Colors.white,
                      )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      });
}
