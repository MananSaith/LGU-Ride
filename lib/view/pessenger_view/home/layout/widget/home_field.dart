import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../configuration/frontend_configs.dart';
class HomeField extends StatelessWidget {
  HomeField(
      {Key? key,
      required this.svg,
      required this.hint,
      required this.controller,
      required this.onTap,
      required this.inputType})
      : super(key: key);
  final String svg;
  final String hint;
  TextInputType inputType;
  TextEditingController controller;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        Expanded(
          child: InkWell(
            onTap: onTap,
            child: TextFormField(
              keyboardType: inputType,
              controller: controller,
              enabled: false,

              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                    color: AppColors.contentDisabled,
                    fontSize: 14,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color:AppColors.contentDisabled)),
                fillColor:Colors.white,
                filled: true,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(svg),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
