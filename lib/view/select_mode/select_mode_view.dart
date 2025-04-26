import 'package:riding_app/utils/app_imports.dart';
import 'package:flutter/material.dart';

import 'layout/body.dart';

class SelectModeView extends StatelessWidget {
  const SelectModeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      body: const SelectModeBody(),
    );
  }


  //
  // Widget _popMenu() {
  //   return PopupMenuButton(
  //       icon: const Icon(
  //         Icons.more_vert,
  //         size: 20,
  //         color: Colors.black,
  //       ),
  //       shape: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(6),
  //           borderSide: BorderSide.none),
  //       itemBuilder: (context) => [
  //             PopupMenuItem(
  //               height:40,
  //                 child: CustomText(
  //               text: 'lahore'.tr(),
  //             )),
  //             PopupMenuItem(
  //               height:40,
  //                 child: CustomText(
  //               text: 'lahore'.tr(),
  //             ))
  //           ]);
  // }
}
