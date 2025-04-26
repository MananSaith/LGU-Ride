import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../configuration/frontend_configs.dart';


class BottomBarWidget extends StatelessWidget {
  final TextEditingController controller;

  BottomBarWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 2.0,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 20.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(30),
                border:Border.all(color:AppColors.contentDisabled)
              ),
              child: TextField(
                textInputAction: TextInputAction.send,
                controller: controller,
                decoration:  InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Write your message here....".tr(),
                    hintStyle: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
          ),
          const SizedBox(width:6,),
          CircleAvatar(
            backgroundColor:AppColors.primary,
            radius: 18,
            child: IconButton(
              icon:SvgPicture.asset('assets/svg/send_icon.svg'),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}