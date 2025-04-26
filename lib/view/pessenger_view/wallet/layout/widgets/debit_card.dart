import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class WalletCardWidget extends StatelessWidget {
  const WalletCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation:3,
      shape:OutlineInputBorder(borderRadius:BorderRadius.circular(17),borderSide:BorderSide.none),
      color:AppColors.primary,
      child: Padding(
        padding: const EdgeInsets.only(right:24.0,left:24,top:28,bottom:28),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CustomText(
                      text: "Andrew Johns".tr(),
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    const SizedBox(height:3,),
                    CustomText(
                      text: '**** **** *** 3636'.tr(),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color:Colors.white,
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/images/card_icon.png',height:25,width:41,),
                    const SizedBox(height:3,),
                    CustomText(
                      text: 'mastercard'.tr(),
                      fontSize: 8,
                      fontWeight: FontWeight.w400,
                      color:Colors.white,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height:24,),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Your Balance'.tr(),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color:Colors.white,
                    ),
                    CustomText(
                      text: '\$250.00'.tr(),
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color:Colors.white,
                    ),
                  ],
                ),
                Container(
                  height: 33,
                  width: 81,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svg/bag_icon.svg'),
                      const SizedBox(width:6,),
                      CustomText(
                        text: 'Top up'.tr(),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
