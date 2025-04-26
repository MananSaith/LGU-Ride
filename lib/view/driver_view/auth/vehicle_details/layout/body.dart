import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class VehicleDetailsViewBody extends StatelessWidget {
  const VehicleDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return StreamProvider.value(
        value: RiderServices()
            .streamRiderVehicle(user.getRiderDetails()!.docId.toString()),
        initialData: [RiderVehicleModel()],
        builder: (context, child) {
          List<RiderVehicleModel> vehicleList =
              context.watch<List<RiderVehicleModel>>();
          return vehicleList.isNotEmpty
              ? vehicleList[0].docId == null
                  ? Center(
                      child: ProcessingWidget(),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Vehicle Name".tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              vehicleList[0].vehicleName.toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              "Vehicle Model Number".tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              vehicleList[0].model.toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              "Vehicle Number Plate".tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              vehicleList[0].vehiclePlateNumber.toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              "Vehicle Documents".tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HeroWidgetView(
                                            image: vehicleList[0]
                                                .vehicleDocuments
                                                .toString())));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: vehicleList[0]
                                      .vehicleDocuments
                                      .toString(),
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Image.asset(
                                    'assets/images/ph.jpg',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/images/ph.jpg',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              "License Image".tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HeroWidgetView(
                                            image: vehicleList[0]
                                                .licenseCardImage
                                                .toString())));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: vehicleList[0]
                                      .licenseCardImage
                                      .toString(),
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Image.asset(
                                    'assets/images/ph.jpg',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/images/ph.jpg',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    )
              : SizedBox();
        });
  }
}
