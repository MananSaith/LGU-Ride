import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class DriverOTPBody extends StatelessWidget {
  DriverOTPBody({Key? key}) : super(key: key);
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 77,
      height: 56,
      textStyle: TextStyle(
          fontSize: 16,
          color: AppColors.primary,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: AppColors.kAuthColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color:Colors.black,width:0.1),
      ),
    );

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:18.0),
          child: Column(
            children: [
              const SizedBox(height:34,),
              Image.asset(
                "assets/images/logo.png",
                height:100,
                width:180,
              ),
              const SizedBox(height:16,),
              RichText(
                  text: TextSpan(
                      text: "Be your own ".tr(),
                      style: TextStyle(
                          color: Color(0xff2F2E41),
                          fontWeight: FontWeight.w400,
                          letterSpacing:1.2,
                          fontSize: 15),children: [
                    TextSpan(
                      text: "Ride.".tr(),
                      style: TextStyle(
                          color:Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),)
                  ])),
              const SizedBox(height:34,),
              Row(
                mainAxisAlignment:MainAxisAlignment.start,
                children: [
                  CustomText(text: 'Please type the verification code sent to \n+92 3********42  '.tr()),
                ],
              ),
              const SizedBox(height:16,),
              Center(
                child: Pinput(
                  controller: pinController,
                  focusNode: focusNode,
                  // androidSmsAutofillMethod:
                  // AndroidSmsAutofillMethod.smsUserConsentApi,
                  // listenForMultipleSmsOnAndroid: true,
                  defaultPinTheme: defaultPinTheme,
                  validator: (value) {
                    return value == '2222' ? null : '';
                  },
                  onClipboardFound: (value) {
                    debugPrint('onClipboardFound: $value');
                    pinController.setText(value);
                  },
                  // hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    debugPrint('onCompleted: $pin');
                  },
                  onChanged: (value) {
                    debugPrint('onChanged: $value');
                  },
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        width: 22,
                        height: 1,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: AppColors.kAuthColor,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color:Colors.black,width:0.1),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color:AppColors.kAuthColor),
                  ),
                ),
              ),
              const SizedBox(height:34,),
              RichText(
                  text:  TextSpan(
                      text: "Click Here".tr(),
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          decoration:TextDecoration.underline
                      ),
                      children:   [
                        TextSpan(
                            text: " to resend code in 50s".tr(),
                            style: TextStyle(
                                color:Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                decoration:TextDecoration.none
                            ))
                      ])),
              const SizedBox(height:44,),
              AppButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const AccountCreatedView()));
              }, btnLabel:'Submit'.tr())
            ],
          ),
        ),
      ),
    );
  }
}
