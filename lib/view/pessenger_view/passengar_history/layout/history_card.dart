import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class HistoryCard extends StatefulWidget {
  final RideModel model;

  HistoryCard({Key? key, required this.model}) : super(key: key);

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  bool isShowDetails = false;
  bool isShowButton = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.kAuthColor,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: widget.model.riderImage.toString(),
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Image.asset(
                            'assets/images/ph.jpg',
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/ph.jpg',
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: widget.model.riderName.toString() == ""
                                ? 'N/A'.tr()
                                : widget.model.riderName.toString(),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          CustomText(
                            text: DateFormat.yMMMMd()
                                .format(widget.model.createdAt!.toDate()),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 28,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:  widget.model.isCompleted == true? Color(0xFF2DBB54):Colors.red,
                        fixedSize: const Size(90, 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    onPressed: () {},
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.model.isCompleted == true
                                ? "Completed".tr()
                                : "Cancelled".tr(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Divider(
              color: AppColors.contentDisabled,
            ),
            isShowDetails
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 36,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isShowDetails = !isShowDetails;
                                });
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: AppColors.primary,
                              )))
                    ],
                  ),
            isShowDetails
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset("assets/svg/location_icon.svg",
                                  color: AppColors.primary),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  CustomText(
                                    text: "${widget.model.distance.toString()}",
                                    fontWeight: FontWeight.w600,
                                  ),
                                  CustomText(
                                    text: "km".tr(),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset("assets/svg/watch_icon.svg"),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomText(
                                text:
                                    "${widget.model.travelTime.toString()} ",
                                fontWeight: FontWeight.w600,
                              ),
                              CustomText(
                                text:
                                "mins".tr(),
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/wallet_icon.svg",
                                color: AppColors.primary,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomText(
                                text: "PKR ".tr(),
                                fontWeight: FontWeight.w600,
                              ),
                              CustomText(
                                text: "${widget.model.amount.toString()}",
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Date & Time'.tr(),
                            color: AppColors.contentDisabled,
                          ),
                          CustomText(
                            text: DateFormat.yMEd()
                                .format(widget.model.createdAt!.toDate()),
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Divider(
                        color: AppColors.contentDisabled,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      RideSelectionWidget(
                        icon: 'assets/svg/pickup_icon.svg',
                        title: 'Pick up Location'.tr(),
                        showTrailing: false,
                        body: widget.model.from.toString(),
                        onPressed: () {},
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: DottedLine(
                          direction: Axis.vertical,
                          lineLength: 30,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: Colors.black,
                          dashRadius: 2.0,
                          dashGapLength: 4.0,
                          dashGapRadius: 0.0,
                        ),
                      ),
                      RideSelectionWidget(
                        icon: 'assets/svg/location_icon.svg',
                        title: 'Drop off Location'.tr(),
                        body: widget.model.to.toString(),
                        showTrailing: false,
                        onPressed: () {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isShowDetails = !isShowDetails;
                                });
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_up_rounded,
                                color: AppColors.primary,
                              ))
                        ],
                      )
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
