import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

Future<void> showRatingSheet(context, RideModel model) {
  bool isLoading = false;
  double rating = 1;
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 18,
                ),
                Container(
                  height: 3,
                  width: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xffE0E0E0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                CustomText(
                  text: 'Arrived at the destination'.tr(),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
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
                DriverProfileWidget(model: model),
                const SizedBox(
                  height: 8,
                ),
                Divider(
                  color: AppColors.contentDisabled,
                ),
                CustomText(
                  text: 'How was your trip with the driver?'.tr(),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomText(
                  text: 'Rate accordingly'.tr(),
                  color: AppColors.contentDisabled,
                ),
                const SizedBox(
                  height: 8,
                ),
                RatingBar.builder(
                  initialRating: 3,
                  glowColor: Colors.amberAccent,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/svg/rating_star.svg',
                      height: 28,
                      width: 28,
                    ),
                  ),
                  onRatingUpdate: (_rating) {
                    rating = _rating;
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                isLoading
                    ? Center(
                        child: ProcessingWidget(),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BottomNavBarView()),
                                  (route) => false);
                            },
                            child: Container(
                              height: 45,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xff252525)
                                      .withOpacity(0.15)),
                              child: Center(
                                child: CustomText(
                                  text: 'Cancel'.tr(),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              isLoading = true;
                              setState(() {});
                              try {
                                await RatingReviewServices()
                                    .addRating(
                                        model: RatingReviewsModel(
                                            giveByID: model.userId.toString(),
                                            rating: rating,
                                            review: "",
                                            giveToID: model.riderId.toString(),
                                            giveByName:
                                                model.userName.toString(),
                                            giveByImage:
                                                model.userImage.toString(),
                                            productID: model.docId.toString()),
                                        userID: model.userId.toString())
                                    .then((value) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavBarView()),
                                      (route) => false);
                                });
                              } catch (e) {
                                getFlushBar(context, title: e.toString());
                              }
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BottomNavBarView()),
                                  (route) => false);
                            },
                            child: Container(
                              height: 45,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColors.primary,
                              ),
                              child: Center(
                                  child: CustomText(
                                text: 'Submit'.tr(),
                                color: Colors.white,
                              )),
                            ),
                          )
                        ],
                      ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
      });
}

Future<void> goingTOPickingUpSheet(context) {
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 3,
                    width: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xffE0E0E0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              // DriverProfileWidget(onTapped: () {}),
              // const SizedBox(
              //   height: 24,
              // ),
              // AppButton(
              //     onPressed: () {
              //       showRatingSheet(context);
              //     },
              //     btnLabel: 'End Trip'),
              // const SizedBox(
              //   height: 10,
              // ),
            ],
          ),
        );
      });
}
