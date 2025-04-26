
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riding_app/utils/app_imports.dart';

class RideStartBody extends StatefulWidget {
  final String rideID;

  const RideStartBody({super.key, required this.rideID});

  @override
  State<RideStartBody> createState() => RideStartBodyState();
}

class RideStartBodyState extends State<RideStartBody> {
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;
  Set<Polyline> _polylines = {};

  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = 'AIzaSyC7aO2ri5wsZEBhI3iqm70A1-m7vTYmehg';
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
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

  @override
  void initState() {
    RideServices().streamRideByID(widget.rideID.toString()).listen((event) {
      if (event.isCompleted == true) {
        rideArrivedDialog(context, event);
      }
    });

    super.initState();
  }

  bool isFirstLoad = true;

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: RideServices().streamRideByID(widget.rideID.toString()),
        initialData: RideModel(),
        builder: (context, child) {
          RideModel rideModel = context.watch<RideModel>();
          if (isFirstLoad) {
            if (rideModel.docId != null) {
              setPolylines(
                sourceLat: rideModel.fromLat!.toDouble(),
                sourceLng: rideModel.fromLng!.toDouble(),
                destLat: rideModel.toLat!.toDouble(),
                destLng: rideModel.toLng!.toDouble(),
              );
              setSourceAndDestinationIcons().then((value) {
                markers.addAll([
                  Marker(
                      markerId: const MarkerId('1'),
                      position: LatLng(rideModel.fromLat!.toDouble(),
                          rideModel.fromLng!.toDouble()),
                      icon: sourceIcon!),
                  Marker(
                      markerId: const MarkerId('2'),
                      position: LatLng(rideModel.toLat!.toDouble(),
                          rideModel.toLng!.toDouble()),
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
                  onWillPop: () async {
                    if (rideModel.isCancelled == true) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBarView()),
                          (route) => false);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CancelRideView(
                                  riderID: rideModel.riderId.toString(),
                                  rideID: widget.rideID.toString())));
                    }
                    return Future.value(true);
                  },
                  child: Scaffold(
                    extendBodyBehindAppBar: true,
                    body: rideModel.isCancelled == true
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Ride has been cancelled by rider.".tr()),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavBarView()),
                                          (route) => false);
                                    },
                                    child: Text("Okay".tr()))
                              ],
                            ),
                          )
                        : Stack(children: [
                            GoogleMap(
                              zoomControlsEnabled: false,
                              mapType: MapType.normal,
                              mapToolbarEnabled: false,
                              polylines: _polylines,
                              markers: markers,
                              myLocationEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(rideModel.fromLat!.toDouble(),
                                    rideModel.fromLng!.toDouble()),
                                zoom: 14.4746,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                            ),
                            SlidingUpPanel(
                              minHeight: 240,
                              maxHeight: 550,
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
                                          text: "Trip to Destination".tr(),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        Row(
                                          children: [
                                            CustomText(
                                                text:
                                                    "${calculateDistance(fromLat: rideModel.fromLat!, fromLng: rideModel.fromLng!, toLat: rideModel.toLat!, toLng: rideModel.toLng!)} ",
                                                color:
                                                    AppColors.contentDisabled,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                            CustomText(
                                                text: "km".tr(),
                                                color:
                                                    AppColors.contentDisabled,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Divider(
                                      color: AppColors.contentDisabled,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    ProfileWidget(
                                      model: rideModel,
                                      onTapped: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DriverDetailsView(
                                                      rideModel: rideModel,
                                                    )));
                                      },
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
                                      body: rideModel.from.toString(),
                                      showTrailing: false,
                                      onPressed: () {},
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: DottedLine(
                                        direction: Axis.vertical,
                                        lineLength: 30,
                                        lineThickness: 1.0,
                                        dashLength: 4.0,
                                        dashColor:
                                            AppColors.primary,
                                        dashRadius: 2.0,
                                        dashGapLength: 4.0,
                                        dashGapRadius: 0.0,
                                      ),
                                    ),
                                    RideSelectionWidget(
                                      icon: 'assets/svg/location_icon.svg',
                                      title: 'Drop off Location'.tr(),
                                      body: rideModel.to.toString(),
                                      showTrailing: false,
                                      onPressed: () {},
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RoundButton(
                                          icon: 'assets/svg/message.svg',
                                          bgColor: AppColors.primary,
                                          svgColor: Colors.white,
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatView(
                                                            model: rideModel)));
                                          },
                                        ),
                                        const SizedBox(
                                          width: 18,
                                        ),
                                        RoundButton(
                                          icon: 'assets/svg/telephone_icon.svg',
                                          bgColor: AppColors.primary,
                                          svgColor: Colors.white,
                                          onPressed: () {
                                            callHelper(rideModel
                                                .riderPhoneNumber
                                                .toString());
                                          },
                                        ),
                                        const SizedBox(
                                          width: 18,
                                        ),
                                        RoundButton(
                                          icon: 'assets/svg/navigator.svg',
                                          bgColor: AppColors.primary,
                                          svgColor: Colors.white,
                                          onPressed: () {
                                            navigationHelper(
                                                rideModel.toLat!.toDouble(),
                                                rideModel.toLng!.toDouble());
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]),
                  ),
                );
        });
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
}
