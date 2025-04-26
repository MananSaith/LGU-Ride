import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';
class DriverProfileWidget extends StatelessWidget {
  final RideModel model;

  DriverProfileWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: model.riderImage.toString(),
                height: 62,
                width: 62,
                memCacheHeight: 500,
                memCacheWidth: 500,
                fit: BoxFit.fill,
                progressIndicatorBuilder:
                    (context, url, downloadProgress) =>
                    Image.asset(
                      'assets/images/ph.jpg',
                      height: 62,
                      width: 62,
                      fit: BoxFit.cover,
                    ),
                errorWidget: (context, url, error) =>
                    Image.asset(
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
                  text: model.riderName.toString(),
                  color: const Color(0xff3F3D56),
                  fontWeight: FontWeight.w600,
                ),
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                CustomText(
                  text: 'PKR '.tr(),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  text: '${model.amount.toString()}.00',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
