import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class RideSelectionWidget extends StatelessWidget {
  RideSelectionWidget(
      {Key? key, required this.icon, required this.title, required this.body,required this.onPressed})
      : super(key: key);
  final String icon;
  final String title;
  final String body;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color:AppColors.primary.withOpacity(0.2)),
              child: Center(
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.primary,),
                  child: Center(
                    child: SvgPicture.asset(
                      icon,color:Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 11,),
            Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height:3,),
                CustomText(
                  text: body,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )
              ],
            )
          ],
        ),

      ],
    );
  }
}
