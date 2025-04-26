import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class RideDetailWidget extends StatelessWidget {
  final RideModel model;

  RideDetailWidget({Key? key, required this.onTapped, required this.model})
      : super(key: key);
  VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: model.userImage.toString(),
                  height: 62,
                  width: 62,
                  memCacheHeight: 500,
                  memCacheWidth: 500,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Image.asset(
                    'assets/images/ph.jpg',
                    height: 62,
                    width: 62,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/ph.jpg',
                    height: 62,
                    width: 62,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 11,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: model.userName.toString(),
                    color: const Color(0xff3F3D56),
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  CustomText(
                    text: model.userPhoneNumber.toString(),
                    color: AppColors.contentDisabled,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: CustomText(
                      text: model.to.toString(),
                      color: AppColors.contentDisabled,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  CustomText(
                    text: "Rs".tr() + model.amount.toString(),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  RoundButton(
                    icon: 'assets/svg/telephone_icon.svg',
                    bgColor: AppColors.primary,
                    svgColor: Colors.white,
                    onPressed: () {
                      callHelper(model.userPhoneNumber.toString());
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RoundButton(
                    icon: 'assets/svg/message.svg',
                    bgColor: AppColors.primary,
                    svgColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatView(
                                    model: model,
                                    isRider: true,
                                  )));
                    },
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
