import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';
class RideSelectionWidget extends StatelessWidget {
  RideSelectionWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.body,
      this.showTrailing = true,
      required this.onPressed})
      : super(key: key);
  final String icon;
  final String title;
  final String body;
  final bool showTrailing;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.2)),
              child: Center(
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.primary,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 11,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 3,
                ),
                Container(
                  width: MediaQuery.of(context).size.width *0.6,
                  child: CustomText(
                    text: body,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            )
          ],
        ),
        if (showTrailing)
          IconButton(
              onPressed: onPressed,
              icon: SvgPicture.asset('assets/svg/edit_icon.svg'))
      ],
    );
  }
}
