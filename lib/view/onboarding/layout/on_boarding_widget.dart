import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class SliderPage extends StatelessWidget {
  SliderPage(
      {Key? key,
      required this.svg,
      required this.body,
      required this.title,
      required this.subBody,

      })
      : super(key: key);
  final String svg;
  final String body;
  final String title;
  final String subBody;
  @override
  Widget build(BuildContext context) {
    return Container(
       color:Colors.white,
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          Image.asset(svg,height:200,),
          const SizedBox(height:12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              CustomText(
                text: title,
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          const SizedBox(height:4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CustomText(text: body)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CustomText(text: subBody)],
          )
        ],
      ),
    );
  }
}
