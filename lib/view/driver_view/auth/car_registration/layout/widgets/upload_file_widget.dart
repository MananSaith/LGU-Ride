import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';



class UploadFileWidget extends StatelessWidget {
  const UploadFileWidget({Key? key, required this.btnLebal, required this.fileName})
      : super(key: key);
  final String btnLebal;
  final String fileName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: fileName,
        ),
        SizedBox(height: 10,),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.kAuthColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8),
            child: Center(
              child: CustomText(
                text: btnLebal,
              ),
            ),
          ),
        )
      ],
    );
  }
}
