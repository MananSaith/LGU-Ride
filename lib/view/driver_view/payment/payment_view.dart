import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';
import 'layout/body.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customAppBar(context,showText:true,text:'Payment Detail'.tr()),
      body:const PaymentBody(),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.only(right:18.0,left:18,bottom:10),
        child: AppButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const TripDetailsView()));
        }, btnLabel: 'Done'.tr(),),
      ),
    );
  }
}
Future<void> addTolDialog(context) async {
  return showDialog<void>(
    context:context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
          // insetPadding:const EdgeInsets.all(6),
          contentPadding: const EdgeInsets.all(12),
          insetPadding: const EdgeInsets.all(10),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          title: Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              CustomText(text: 'Add Toll'.tr(),fontSize:21,fontWeight:FontWeight.w600,)
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(text: "Enter sum of the all toll price".tr(),color:AppColors.contentDisabled,),
               const SizedBox(height:6,),
                SizedBox(
                  height:52,
                  child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Toll Price \$0.00'.tr(),
                          hintStyle: TextStyle(
                              color: AppColors.contentDisabled,
                              fontSize: 16,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none),
                          fillColor:AppColors.kAuthColor,
                          filled:true
                      )),
                ),
                const SizedBox(height: 18,),
                AppButton(onPressed: () {
                  Navigator.pop(context);
                }, btnLabel: 'Done'.tr(),),

                const SizedBox(
                  height: 18,
                ),
              ],
            ),
          ));
    },
  );
}