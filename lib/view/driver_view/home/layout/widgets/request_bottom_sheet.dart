import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

Future<void> requestBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (dialogContext) {
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
                    text: "New Request".tr(),
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
               Padding(
                padding: EdgeInsets.only(left: 20),
                child: DottedLine(
                  direction: Axis.vertical,
                  lineLength: 30,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: AppColors.primary,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap:(){
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
                          text: 'Reject'.tr(),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap:(){
                      Navigator.pop(dialogContext);
                pickUpBottomSheetSheet(context);
                    },
                    child: Container(
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.primary,),
                      child: Center(
                          child: CustomText(
                            text: 'Accept'.tr(),
                            color: Colors.white,
                          )),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      });
}