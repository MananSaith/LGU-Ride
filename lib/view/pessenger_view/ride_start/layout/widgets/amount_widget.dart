import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';
class RiderTip extends StatelessWidget {
   RiderTip({Key? key, required this.amount,required this.color}) : super(key: key);
  final String amount;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 77,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.contentDisabled)),
      child: Center(
        child: CustomText(
          text: amount,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
