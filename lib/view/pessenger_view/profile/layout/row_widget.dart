import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../configuration/frontend_configs.dart';
class SettingWidget extends StatelessWidget {
  SettingWidget(
      {Key? key,
      required this.icon,
      required this.title,
      this.isShow = false,
        this.height=20,
        this.weight=20,
        required this.onTap,
      required this.name})
      : super(key: key);
  final String icon;
  final String title;
  final String name;
  bool isShow;
  double height;
  double weight;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:8.0,horizontal:18),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon,
                  height: height,
                  width: weight,
                  color:AppColors.contentDisabled,
                ),
                const SizedBox(width:18,),
                Text(name,
                    style: TextStyle(
                        color:AppColors.contentDisabled,
                        fontSize: 14,
                        fontWeight: FontWeight.w400))
              ],
            ),
            isShow
                ? Text(
                    title,
                    style: TextStyle(
                        color: AppColors.contentDisabled,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                : const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  )
          ],
        ),
      ),
    );
  }
}
