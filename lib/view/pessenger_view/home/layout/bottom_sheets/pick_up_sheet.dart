import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


Future<void> piUpLocationBottomSheet(context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize:MainAxisSize.min,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Distance".tr(),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                      text: "4.8 km".tr(),
                      fontSize: 14,
                      fontWeight: FontWeight.w600)
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Divider(
                color: AppColors.contentDisabled,
              ),
              const SizedBox(
                height: 10,
              ),
              HomeSelectionWidget(
                icon: 'assets/svg/pickup_icon.svg',
                title: 'Pick up Location'.tr(),
                body: '089 Stark Gateway'.tr(), onPressed: () {  },),
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
              HomeSelectionWidget(
                icon: 'assets/svg/location_icon.svg',
                title: 'Drop off Location'.tr(),
                body: '92676 Orion Meadows'.tr(), onPressed: () {  },),
              const SizedBox(
                height: 34,
              ),
              AppButton(onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>const SelectCarView()));
              }, btnLabel: "Confirm Location".tr()),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      });
}