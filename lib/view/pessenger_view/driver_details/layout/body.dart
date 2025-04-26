import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class DriverDetailsBody extends StatelessWidget {
  final RiderModel model;

  const DriverDetailsBody({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {

        return StreamProvider.value(
            value: RiderServices().streamRiderVehicle(model.docId.toString()),
            initialData: [RiderVehicleModel()],
            builder: (context, child) {
              List<RiderVehicleModel> vehicleModel =
                  context.watch<List<RiderVehicleModel>>();
              return vehicleModel.isNotEmpty
                  ? vehicleModel[0].docId == null
                      ? Center(
                          child: ProcessingWidget(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl: model.image.toString(),
                                  height: 80,
                                  width: 80,
                                  memCacheHeight: 500,
                                  memCacheWidth: 500,
                                  fit: BoxFit.fill,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Image.asset(
                                    'assets/images/ph.jpg',
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  errorWidget: (context, url, error) => Image.asset(
                                    'assets/images/ph.jpg',
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              CustomText(
                                text: model.name.toString(),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomText(
                                text: model.phoneNumber.toString(),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              DriverDetailsWidget(
                                model: model,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Container(
                                height: 171,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: 'Member Since'.tr(),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: AppColors.contentDisabled,
                                          ),
                                          const SizedBox(
                                            height: 18,
                                          ),
                                          CustomText(
                                            text: 'Car Model'.tr(),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: AppColors.contentDisabled,
                                          ),
                                          const SizedBox(
                                            height: 18,
                                          ),
                                          CustomText(
                                            text: 'Plate Number'.tr(),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: AppColors.contentDisabled,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          CustomText(
                                            text: DateFormat.y().format(
                                                DateTime.fromMillisecondsSinceEpoch(
                                                    model.createdAt!)),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          const SizedBox(
                                            height: 18,
                                          ),
                                          CustomText(
                                            text: vehicleModel[0]
                                                .vehicleName
                                                .toString(),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          const SizedBox(
                                            height: 18,
                                          ),
                                          CustomText(
                                            text: vehicleModel[0]
                                                .vehiclePlateNumber
                                                .toString(),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                  : SizedBox();
            });

  }
}
