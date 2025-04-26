import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class ProfileWidget extends StatelessWidget {
  final RideModel model;

  ProfileWidget({Key? key, required this.onTapped, required this.model})
      : super(key: key);
  VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: RatingReviewServices().streamMyReviews(model.riderId.toString()),
        initialData: [RatingReviewsModel()],
        builder: (context, child) {
          List<RatingReviewsModel> ratingList =
              context.watch<List<RatingReviewsModel>>();
          return StreamProvider.value(
              value:
                  RiderServices().streamRiderVehicle(model.riderId.toString()),
              initialData: [RiderVehicleModel()],
              builder: (context, child) {
                List<RiderVehicleModel> vehicleModel =
                    context.watch<List<RiderVehicleModel>>();
                return vehicleModel.isNotEmpty
                    ? vehicleModel[0].docId == null
                        ? Center(
                            child: ProcessingWidget(),
                          )
                        : InkWell(
                            onTap: onTapped,
                            child: Row(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: model.riderName.toString(),
                                          color: const Color(0xff3F3D56),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        CustomText(
                                          text: vehicleModel[0]
                                              .vehicleName
                                              .toString(),
                                          color: AppColors.contentDisabled,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                "assets/svg/star_icon.svg"),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            if (ratingList.isNotEmpty)
                                              if (ratingList[0].docId != null)
                                                CustomText(
                                                    text: RatingCalculator
                                                            .calculateRating(
                                                                ratingList
                                                                    .map((e) => e
                                                                        .rating!)
                                                                    .toList())
                                                        .toStringAsFixed(1))
                                              else

                                                CustomText(
                                                    text: 'Calculating..'.tr())
                                            else
                                              CustomText(text: 'N/A'.tr())
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        CustomText(
                                          text: vehicleModel[0]
                                              .vehiclePlateNumber
                                              .toString(),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                    : SizedBox();
              });
        });
  }
}
