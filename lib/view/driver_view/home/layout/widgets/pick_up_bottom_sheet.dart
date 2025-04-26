import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

Future<void> pickUpBottomSheetSheet(context) {
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (dialogContext) {
        Timer(const Duration(seconds: 3),(){
          Navigator.pop(dialogContext);
          goingTOPickingUpSheet(context);
        });
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 3,
                    width: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xffE0E0E0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Picking up".tr(),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Divider(
                color: AppColors.contentDisabled,
              ),
              const SizedBox(
                height: 8,
              ),
              // DriverProfileWidget(onTapped: (){}),
              const SizedBox(
                height: 8,
              ),
              Divider(
                color: AppColors.contentDisabled,
              ),
              const SizedBox(
                height: 8,
              ),
              RideSelectionWidget(
                icon: 'assets/svg/pickup_icon.svg',
                title: 'Pick up Location'.tr(),
                body: '089 Stark Gateway'.tr(),
                onPressed: () {},
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: DottedLine(
                  direction: Axis.vertical,
                  lineLength: 30,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 2.0,
                  dashGapLength: 4.0,
                  dashGapRadius: 0.0,
                ),
              ),
              RideSelectionWidget(
                icon: 'assets/svg/location_icon.svg',
                title: 'Drop off Location'.tr(),
                body: '92676 Orion Meadows'.tr(),
                onPressed: () {},
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundButton(
                    icon: 'assets/svg/cancel_icon.svg',
                    customHeight:16,
                    customWidth:16,
                    bgColor: AppColors.kAuthColor,
                    svgColor: Colors.white,
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  RoundButton(
                    icon: 'assets/svg/message.svg',
                    bgColor: AppColors.primary,
                    svgColor: Colors.white,
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  RoundButton(
                    icon: 'assets/svg/telephone_icon.svg',
                    bgColor: AppColors.primary,
                    svgColor: Colors.white,
                    onPressed: () {},
                  )
                ],
              )

            ],
          ),
        );
      });
}