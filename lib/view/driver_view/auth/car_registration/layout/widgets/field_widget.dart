import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';



// ignore: must_be_immutable
class RegistrationFieldWidget extends StatelessWidget {
  RegistrationFieldWidget(
      {Key? key,
      required this.controller,
      required this.keyBoardType,
      required this.text})
      : super(key: key);
  TextInputType keyBoardType;
  String text;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 49,
      child: TextFormField(
        keyboardType: keyBoardType,
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
              color: AppColors.contentDisabled,
              fontSize: 14,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
borderSide: BorderSide.none
              ),
          fillColor:AppColors.kAuthColor,
          filled: true,
        ),
      ),
    );
  }
}
