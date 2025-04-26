import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class SelectCarBody extends StatelessWidget {
  const SelectCarBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const SizedBox(height:18,),
              CustomText(
                text: 'Select a vehicle category you want to ride'.tr(),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              // const SizedBox(height:14,),
              //  SelectCarWidget(
              //     svg: 'assets/images/wagon_car.png',
              //     name: 'Mercedes Vito'.tr(),
              //     distance: "2 Near by".tr(),
              //     amount: '\$10.40'.tr()),
              //  SelectCarWidget(
              //     svg: 'assets/images/mercedies_car.png',
              //     name: 'Audi A7'.tr(),
              //     distance: "2 Near by".tr(),
              //     amount: '\$14.40'.tr()),
              //  SelectCarWidget(
              //     svg: 'assets/images/mercedies_car.png',
              //     name: 'Mercedes Benz'.tr(),
              //     distance: "2 Near by".tr(),
              //     amount: '\$15.40'.tr())
            ],
          ),
        ),
      ),
    );
  }
}
