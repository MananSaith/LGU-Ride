import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class WalletDriverWidget extends StatelessWidget {
  const WalletDriverWidget(
      {Key? key,
        required this.profileImage,
        required this.name,
        required this.details,
      })
      : super(key: key);
  final String profileImage;
  final String name;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
                radius: 25,
                child: Image.asset(
                  profileImage,
                  fit: BoxFit.fill,
                )),
            const SizedBox(
              width: 11,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 3,
                ),
                CustomText(
                  text: details,
                  fontSize: 12,
                ),
              ],
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                CustomText(text: "          \$10.00".tr(),fontSize:16,fontWeight:FontWeight.w600,),
              ],
            ),
            const SizedBox(height:5,),
            Row(
              children: [
                CustomText(
                  text: 'Taxi Expenses'.tr(),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(width:5,),
                SvgPicture.asset('assets/svg/red_arrow.svg')
              ],
            )
          ],
        )
      ],
    );
  }
}
