import 'package:flutter/material.dart';
import '../configuration/frontend_configs.dart';
customAppBar(
  BuildContext context, {
  String? text,
  bool showText = false,
  bool showBackButton = true,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    scrolledUnderElevation: 0.0,
    centerTitle: true,
    leading: showBackButton ?
    IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size:20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ) : SizedBox(),
    title: showText
        ? Text(
            text!,
            style: TextStyle(
                color:AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          )
        : const SizedBox(),

    elevation: 0,
  );
}
