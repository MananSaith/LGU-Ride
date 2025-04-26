import 'package:flutter/material.dart';

import '../configuration/frontend_configs.dart';

class AppButton extends StatelessWidget {
  VoidCallback onPressed;
  String btnLabel;
  double width;
  double height;
  Color? color;
  bool showIcon;
  Color? borderColor;

  AppButton(
      {required this.onPressed,
      required this.btnLabel,
      this.showIcon = false,
      this.color,
      this.width = double.infinity,
      this.borderColor = const Color(0xff027AFE),
      this.height = 51});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primary,
          fixedSize: Size(width, height),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(8)))),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            btnLabel,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
