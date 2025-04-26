
import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class SelectCarWidget extends StatefulWidget {
  final VehicleModel model;
  final VoidCallback onTap;
  final bool isSelected;
  final num totalDistance;

  SelectCarWidget(
      {Key? key,
      required this.model,
      required this.onTap,
      required this.totalDistance,
      required this.isSelected})
      : super(key: key);

  @override
  State<SelectCarWidget> createState() => _SelectCarWidgetState();
}

class _SelectCarWidgetState extends State<SelectCarWidget> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        color: AppColors.kAuthColor,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none),
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.model.image.toString(),
                    height: 62,
                    width: 62,
                    memCacheHeight: 500,
                    memCacheWidth: 500,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Image.asset(
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
                  const SizedBox(
                    width: 11,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: widget.model.vehicleName.toString().tr(),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  if (widget.isSelected)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: SizedBox(
                          height: 10,
                          child: Icon(
                            Icons.check_circle,
                            color: AppColors.primary,
                            size: 16,
                          )),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                        height: 10,
                      ),
                    ),
                  Container(
                    height: 10,
                  ),
                  SizedBox(
                    height: context.locale.languageCode != "en" ? 30 : 20,
                    child: CustomText(
                      text: "PKR : ".tr() +
                          (widget.model.perKmPrice! * widget.totalDistance)
                              .toString(),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
