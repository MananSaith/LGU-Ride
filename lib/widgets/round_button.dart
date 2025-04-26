

// ignore: must_be_immutable
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../configuration/frontend_configs.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final dynamic icon; // Can be IconData or SVG String
  final String? text;
  final Color? bgColor;
  final Color? svgColor;
  final Color? textColor;
  final double? textSize; // Optional text size
  final FontWeight? fontWeight; // Optional font weight
  final double? customHeight;
  final double? customWidth;

  const RoundButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.text,
    this.customHeight,
    this.customWidth,
    this.bgColor,
    this.svgColor = Colors.white,
    this.textColor = Colors.white,
    this.textSize, // Allow custom text size
    this.fontWeight,  // Allow custom font weight
  });

  @override
  Widget build(BuildContext context) {
    // Get screen size dynamically
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust width & height based on screen size
    double buttonWidth = customWidth ?? screenWidth * 0.4;
    double buttonHeight = customHeight ?? screenHeight * 0.07;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? AppColors.primary,
        fixedSize: Size(buttonWidth, buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onPressed: onPressed,
      child: Center(
        child: icon != null
            ? icon is String
            ? SvgPicture.asset(
          icon!,
          height: buttonHeight * 0.6, // Adjust SVG size
          width: buttonWidth * 0.6,
          colorFilter: ColorFilter.mode(
            svgColor ?? AppColors.primary,
            BlendMode.srcIn,
          ),
        )
            : Icon(icon, color: textColor, size: buttonHeight * 0.5)
            : text != null
            ? Text(
          text!,
          style: TextStyle(
            color: textColor ?? Colors.white, // Default to white
            fontSize: textSize ?? buttonHeight * 0.4, // Use custom or auto font size
            fontWeight: fontWeight ?? FontWeight.bold, // Use custom or default bold
          ),
        )
            : const SizedBox(),
      ),
    );
  }
}
