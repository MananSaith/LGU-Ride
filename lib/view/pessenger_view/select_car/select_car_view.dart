import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class SelectCarView extends StatefulWidget {
  final String from;
  final num fromLat;
  final num fromLng;
  final String to;
  final num toLat;
  final num toLng;

  SelectCarView(
      {Key? key,
      required this.to,
      required this.from,
      required this.fromLat,
      required this.fromLng,
      required this.toLat,
      required this.toLng})
      : super(key: key);

  @override
  State<SelectCarView> createState() => _SelectCarViewState();
}

class _SelectCarViewState extends State<SelectCarView> {
  double distance = 0;

  String time = "Calculating...".tr();

  num amount = 0;

  bool isLoading = false;
  VehicleModel? selectedVehicle;

  @override
  void initState() {
    distance = calculateDistance(
        fromLat: widget.fromLat,
        fromLng: widget.fromLng,
        toLat: widget.toLat,
        toLng: widget.toLng);
    getTime();
    super.initState();
  }

  getTime()async{

    //"error_message" : "You must enable Billing on the Google Cloud Project at
   await  RideServices()
        .calculateTime(
        startLat: widget.fromLat.toDouble(),
        startLng: widget.fromLng.toDouble(),
        endLat: widget.toLat.toDouble(),
        endLng: widget.toLng.toDouble())
        .then((value) {
      time = value;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return StreamProvider.value(
        value: VehicleServices().streamVehicles(),
        initialData: [VehicleModel()],
        builder: (context, child) {
          List<VehicleModel> vehicleList = context.watch<List<VehicleModel>>();

          print("=================== lenght ${vehicleList.length} ========== ${vehicleList[0].docId}");
          return LoadingOverlay(
            isLoading: isLoading,
            progressIndicator: ProcessingWidget(),
            color: Colors.transparent,
            child: Scaffold(
              appBar: customAppBar(context,
                  text: "Select your Car".tr(), showText: true),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 18,
                      ),
                      CustomText(
                        text: 'Select a vehicle category you want to ride'.tr(),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      vehicleList.isNotEmpty
                          ? vehicleList[0].docId == null
                              ? Center(
                                  child: ProcessingWidget(),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                      itemCount: vehicleList.length,
                                      itemBuilder: (context, i) {
                                        return SelectCarWidget(
                                          model: vehicleList[i],
                                          totalDistance: distance,
                                          onTap: () {
                                            selectedVehicle = vehicleList[i];
                                            setState(() {});
                                          },
                                          isSelected: selectedVehicle == null
                                              ? false
                                              : vehicleList[i].docId ==
                                                  selectedVehicle!.docId
                                                      .toString(),
                                        );
                                      }))
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      color: AppColors.kAuthColor,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide.none),
                      elevation: 0.5,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 12.0, left: 12, top: 30, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/svg/location_icon.svg"),
                                const SizedBox(
                                  width: 7,
                                ),
                                CustomText(text: '$distance '),
                                CustomText(text: 'km'.tr())
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/watch_icon.svg",
                                  color: AppColors.contentDisabled,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                CustomText(text: '$time'.tr())
                              ],
                            ),
                            if (selectedVehicle != null)
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      "assets/svg/amount_icon.svg"),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  CustomText(
                                      text:
                                          'PKR: '.tr()),
                                  CustomText(
                                      text:
                                      '${selectedVehicle!.perKmPrice! * distance}')
                                ],
                              )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppButton(
                        onPressed: () async {
                          if (selectedVehicle == null) {
                            getFlushBar(context,
                                title: "Kindly select vehicle type.".tr());
                            return;
                          }
                          isLoading = true;
                          setState(() {});
                          try {
                            await RideServices()
                                .createRide(
                                    model: RideModel(
                              from: widget.from,
                              to: widget.to,
                              riderId: "",
                              riderName: "",
                              riderImage: "",
                              riderPhoneNumber: "",
                              distance: distance,
                              travelTime: time,
                              amount: selectedVehicle!.perKmPrice! * distance,
                              fromLng: widget.fromLng,
                              fromLat: widget.fromLat,
                              toLat: widget.toLat,
                              toLng: widget.toLng,
                              vehicleType: selectedVehicle!.docId.toString(),
                              userId: user.getUserDetails()!.docId.toString(),
                              userName: user.getUserDetails()!.name.toString(),
                              vehicleIcon: selectedVehicle!.icon.toString(),
                              userImage:
                                  user.getUserDetails()!.image.toString(),
                              userPhoneNumber:
                                  user.getUserDetails()!.phoneNumber.toString(),
                              isPending: true,
                            ))
                                .then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchingDriverView(
                                            rideID: value,
                                            vehicleID: selectedVehicle!.docId
                                                .toString(),
                                            vehicleImage: selectedVehicle!.icon
                                                .toString(),
                                          )));
                            });
                          } catch (e) {
                            getFlushBar(context, title: e.toString());
                          } finally {
                            isLoading = false;
                            setState(() {});
                          }
                        },
                        btnLabel: 'Continue'.tr()),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
