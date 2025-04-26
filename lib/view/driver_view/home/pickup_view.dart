
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';
import 'package:flutter/services.dart';


class PickupView extends StatefulWidget {
  final RideModel model;

  const PickupView({super.key, required this.model});

  @override
  State<PickupView> createState() => _PickupViewState();
}

class _PickupViewState extends State<PickupView> {
  double lat = 0.0;
  double lng = 0.0;
  BitmapDescriptor? destinationIcon;
  BitmapDescriptor? sourceIcon;
  final Completer<GoogleMapController> _controller = Completer();

  String googleAPIKey = 'AIzaSyC7aO2ri5wsZEBhI3iqm70A1-m7vTYmehg';

  Future setSourceAndDestinationIcons() async {
    final Uint8List icon1 =
        await getBytesFromAsset('assets/images/to_marker.png', 80);

    sourceIcon = await BitmapDescriptor.fromBytes(icon1);
    setState(() {});
    final Uint8List icon2 =
        await getBytesFromAsset('assets/images/from_marker.png', 80);

    destinationIcon = await BitmapDescriptor.fromBytes(icon2);
    setState(() {});
    return Future.value(true);
  }

  setPolylines(
      {required double sourceLat,
      required double sourceLng,
      required double destLat,
      required double destLng}) async {
    print("Results");
    PolylineResult? result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: googleAPIKey,
      // PointLatLng(sourceLat, sourceLng),
      // PointLatLng(destLat, destLng),
      request: PolylineRequest(
          origin: PointLatLng(sourceLat, sourceLng),
          destination: PointLatLng(destLat, destLng),
          mode: TravelMode.driving),
    );

    print(result.status);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      Polyline polyline = Polyline(
          width: 5,
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);

      _polylines.add(polyline);
    });
  }

  bool isLoading = false;

  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    var location = Provider.of<LocationProvider>(context, listen: false);
    if (location.getCurrentLocation() != null) {
      lat = location.getCurrentLocation()!.latitude;
      lng = location.getCurrentLocation()!.longitude;

      markers.addAll([
        Marker(
          markerId: const MarkerId('2'),
          position: LatLng(lat, lng),
        ),
      ]);
    }

    super.initState();
  }

  Set<Marker> markers = {};

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: ProcessingWidget(),
      color: Colors.transparent,
      child: Scaffold(
        body: _getBody(context),
      ),
    );
  }

  bool isFirstLoad = true;

  Widget _getBody(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return StreamProvider.value(
        value: RideServices().streamRideByID(widget.model.docId.toString()),
        initialData: RideModel(),
        builder: (context, child) {
          RideModel rideModel = context.watch<RideModel>();
          if (isFirstLoad) {
            if (rideModel.docId != null) {
              setPolylines(
                sourceLat: lat,
                sourceLng: lng,
                destLat: rideModel.fromLat!.toDouble(),
                destLng: rideModel.fromLng!.toDouble(),
              );
              setSourceAndDestinationIcons().then((value) {
                markers.addAll([
                  Marker(
                      markerId: const MarkerId('1'),
                      position: LatLng(lat, lng),
                      icon: sourceIcon!),
                  Marker(
                      markerId: const MarkerId('2'),
                      position: LatLng(rideModel.fromLat!.toDouble(),
                          rideModel.fromLng!.toDouble()),
                      icon: destinationIcon!),
                ]);
              });

              isFirstLoad = false;
            }
          }
          return rideModel.docId == null
              ? Center(
                  child: ProcessingWidget(),
                )
              : WillPopScope(
                  child: rideModel.isCancelled == true
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Ride has been cancelled by passenger.".tr()),
                              ElevatedButton(
                                  onPressed: () {
                                    RiderServices().updateBusyStatus(
                                        model: RiderModel(
                                            docId: user
                                                .getRiderDetails()!
                                                .docId
                                                .toString(),
                                            isBusy: false));
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DriverHomeView()),
                                        (route) => false);
                                  },
                                  child: Text("Okay".tr()))
                            ],
                          ),
                        )
                      : Scaffold(
                          extendBodyBehindAppBar: true,
                          appBar: AppBar(
                            elevation: 0,
                            leading: SizedBox(),
                            leadingWidth: 0,
                            backgroundColor: Colors.transparent,
                            title: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CancelRideView(
                                              rideID:
                                                  rideModel.docId.toString(),
                                              isRider: true,
                                              riderID:
                                                  rideModel.riderId.toString(),
                                            )));
                              },
                              child: Text(
                                "Cancel".tr(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          body: Stack(children: [
                            GoogleMap(
                              zoomControlsEnabled: false,
                              mapType: MapType.normal,
                              mapToolbarEnabled: false,
                              myLocationEnabled: false,
                              polylines: _polylines,
                              compassEnabled: false,
                              markers: markers,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(lat, lng),
                                tilt: 30.440717697143555,
                                zoom: 16.4746,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                            ),
                            Positioned(
                              bottom: 400,
                              right: 10,
                              child: FloatingActionButton.extended(
                                backgroundColor: AppColors.primary,
                                onPressed: () {
                                  if (rideModel.isArrived == true) {
                                    navigationHelper(
                                        rideModel.toLat!.toDouble(),
                                        rideModel.toLng!.toDouble());
                                  } else {
                                    navigationHelper(
                                        rideModel.fromLat!.toDouble(),
                                        rideModel.fromLng!.toDouble());
                                  }
                                },
                                label: Text("Navigate".tr()),
                                icon: Icon(CupertinoIcons.location_fill),
                              ),
                            ),
                            SlidingUpPanel(
                              minHeight: 370,
                              maxHeight: 420,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              panel: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 3,
                                          width: 36,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffE0E0E0),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: "Okab Riders".tr(),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        CustomText(
                                            text: "3 min".tr(),
                                            color: AppColors.contentDisabled,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Divider(
                                      color: AppColors.contentDisabled,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RideDetailWidget(
                                      model: rideModel,
                                      onTapped: () {},
                                    ),
                                    const SizedBox(
                                      height: 34,
                                    ),
                                    AppButton(
                                        onPressed: () async {
                                          try {
                                            isLoading = true;
                                            setState(() {});
                                            if (rideModel.isArrived == false) {
                                              _polylines.clear();
                                              setState(() {});
                                              setPolylines(
                                                sourceLat: rideModel.fromLat!
                                                    .toDouble(),
                                                sourceLng: rideModel.fromLng!
                                                    .toDouble(),
                                                destLat:
                                                    rideModel.toLat!.toDouble(),
                                                destLng:
                                                    rideModel.toLng!.toDouble(),
                                              );
                                              setSourceAndDestinationIcons()
                                                  .then((value) {
                                                markers.addAll([
                                                  Marker(
                                                      markerId:
                                                          const MarkerId('1'),
                                                      position: LatLng(
                                                          rideModel.fromLat!
                                                              .toDouble(),
                                                          rideModel.fromLng!
                                                              .toDouble()),
                                                      icon: sourceIcon!),
                                                  Marker(
                                                      markerId:
                                                          const MarkerId('2'),
                                                      position: LatLng(
                                                          rideModel.toLat!
                                                              .toDouble(),
                                                          rideModel.toLng!
                                                              .toDouble()),
                                                      icon: destinationIcon!),
                                                ]);
                                              });
                                              await RideServices().startRide(
                                                  rideID: rideModel.docId
                                                      .toString(),
                                                  model: rideModel);
                                            } else {
                                              await RideServices()
                                                  .finishRide(
                                                      rideID: rideModel.docId
                                                          .toString(),
                                                      model: rideModel)
                                                  .then((value) async {
                                                await RiderServices()
                                                    .updateBusyStatus(
                                                        model: RiderModel(
                                                            docId: rideModel
                                                                .riderId
                                                                .toString(),
                                                            rideID: "",
                                                            isBusy: false));
                                                showNavigationDialog(context,
                                                    message:
                                                        "Ride has been completed successfully.".tr(),
                                                    buttonText: "Okay".tr(),
                                                    navigation: () {
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DriverHomeView()),
                                                      (route) => false);
                                                },
                                                    secondButtonText:
                                                        "secondButtonText",
                                                    showSecondButton: false);
                                              });
                                            }
                                          } catch (e) {
                                            getFlushBar(context,
                                                title: e.toString());
                                          } finally {
                                            isLoading = false;
                                            setState(() {});
                                          }
                                        },
                                        btnLabel: rideModel.isArrived == true
                                            ? "Finish this Ride".tr()
                                            : "Start Ride".tr()),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                  onWillPop: () async {
                    if (rideModel.isCancelled == true) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DriverHomeView()),
                          (route) => false);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CancelRideView(
                                  riderID: rideModel.riderId.toString(),
                                  rideID: rideModel.docId.toString())));
                    }
                    return Future.value(true);
                  });
        });
  }
}
