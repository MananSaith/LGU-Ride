import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class PaymentCardWidget extends StatelessWidget {
  const PaymentCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape:OutlineInputBorder(borderRadius:BorderRadius.circular(8),borderSide:BorderSide.none),
      elevation:0,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          height:200,
          width:MediaQuery.of(context).size.width,
          decoration:BoxDecoration(
            borderRadius:BorderRadius.circular(8)
          ),
          child:Column(children: [
            const SizedBox(height:12,),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Toll Amount'.tr(),fontSize:16,fontWeight:FontWeight.w300,color:AppColors.contentDisabled,),
                CustomText(text: '\$0.00'.tr(),fontSize:16,fontWeight:FontWeight.w600,),
              ],
            ),
            const SizedBox(height:24,),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Payment method'.tr(),fontSize:16,fontWeight:FontWeight.w300,color:AppColors.contentDisabled),
                CustomText(text: 'E-Wallet'.tr(),fontSize:16,fontWeight:FontWeight.w600,),
              ],
            ),
            const SizedBox(height:24,),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Ride Fare'.tr(),fontSize:16,fontWeight:FontWeight.w300,color:AppColors.contentDisabled),
                CustomText(text: '\$27.00'.tr(),fontSize:16,fontWeight:FontWeight.w600,),
              ],
            ),
            const SizedBox(height:12,),
            Divider(color:AppColors.contentDisabled,),
            const SizedBox(height:12,),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Total Amount'.tr(),fontSize:16,fontWeight:FontWeight.w600,),
                CustomText(text: '\$30.00'.tr(),fontSize:16,fontWeight:FontWeight.w600,),
              ],
            )
          ],),
        ),
      ),
    );
  }
}
