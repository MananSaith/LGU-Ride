import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class DriverDetailsWidget extends StatelessWidget {
  final RiderModel model;

  const DriverDetailsWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: RideServices().streamRiderRides(model.docId.toString()),
        initialData: [RideModel()],
        builder: (context, child) {
          List<RideModel> rideList = context.watch<List<RideModel>>();
          return StreamProvider.value(
              value: RatingReviewServices()
                  .streamMyReviews(model.docId.toString()),
              initialData: [RatingReviewsModel()],
              builder: (context, child) {
                List<RatingReviewsModel> ratingList =
                    context.watch<List<RatingReviewsModel>>();
                return Container(
                  height: 171,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            RoundButton(
                              onPressed: () {},
                              icon: 'assets/svg/star_icon.svg',
                              svgColor: Colors.white,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            if (ratingList.isNotEmpty)
                              if (ratingList[0].docId != null)
                                CustomText(
                                  text: RatingCalculator.calculateRating(
                                          ratingList
                                              .map((e) => e.rating!)
                                              .toList())
                                      .toStringAsFixed(1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                )
                              else
                                CustomText(text: 'Calculating..'.tr())
                            else
                              CustomText(text: 'N/A'.tr()),
                            CustomText(
                              text: 'Rating'.tr(),
                              color: AppColors.contentDisabled,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            RoundButton(
                              onPressed: () {},
                              icon: 'assets/svg/car_icon.svg',
                              svgColor: Colors.white,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            CustomText(
                              text: rideList.length.toStringAsFixed(0),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomText(
                              text: 'Trips'.tr(),
                              color: AppColors.contentDisabled,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            RoundButton(
                              onPressed: () {},
                              icon: 'assets/svg/watch_icon.svg',
                              svgColor: Colors.white,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            CustomText(
                              text: DateTime.now()
                                  .difference(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          model.createdAt!))
                                  .inDays
                                  .toStringAsFixed(0),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomText(
                              text: 'Days'.tr(),
                              color: AppColors.contentDisabled,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
