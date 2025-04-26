import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class PaymentBody extends StatelessWidget {
  const PaymentBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:18.0),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              const SizedBox(height:18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: "Total Amount".tr()),
                  InkWell(
                    onTap:(){
                      addTolDialog(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          color: AppColors.primary,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomText(text: "Add Toll".tr()),
                      ],
                    ),
                  ),
                ],
              ),
              CustomText(
                text: "\$30.00".tr(),
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height:12,),
              const PaymentCardWidget()
            ],
          ),
        ),
      ),
    );
  }
}
