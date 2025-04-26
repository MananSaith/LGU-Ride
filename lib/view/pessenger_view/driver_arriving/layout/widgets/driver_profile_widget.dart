import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
                radius: 26,
                child: Image.asset(
                  "assets/images/profile.png",
                  fit: BoxFit.fill,
                )),
            const SizedBox(width:11,),
            Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Daniel Austin".tr(),
                  color: const Color(0xff3F3D56),
                  fontWeight:FontWeight.w600,
                ),
                const SizedBox(height:3,),
                CustomText(
                  text: "Mercedes Benz E-Class".tr(),
                  color: AppColors.contentDisabled,
                ),
              ],
            )
          ],
        ),
        Row(children: [
          Column(
            children: [
            Row(
              children: [
                SvgPicture.asset("assets/svg/star_icon.svg"),
                const SizedBox(width:3,),
                CustomText(text: '4.9'.tr())
              ],
            ),
            const SizedBox(height:3,),
            CustomText(text: 'HAX-234'.tr())
          ],)
        ],)
      ],
    );
  }
}
