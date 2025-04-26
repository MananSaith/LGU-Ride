
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';
import 'package:flutter/services.dart';

//import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  TextEditingController _pickUpController = TextEditingController();
  TextEditingController _dropLocationController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? destinationIcon;
  double lat = 0.0;
  double lng = 0.0;

  Set<Marker> markers = {};
  PickResult? fromResult;
  PickResult? toResult;
  Set<Polyline> _polylines = {};

  String googleAPIKey = 'AIzaSyC7aO2ri5wsZEBhI3iqm70A1-m7vTYmehg';
  List<LatLng> polylineCoordinates = [];

  PolylinePoints polylinePoints = PolylinePoints();
  BitmapDescriptor? sourceIcon;

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

    sourceIcon = await BitmapDescriptor.bytes(icon1);
    setState(() {});
    final Uint8List icon2 =
        await getBytesFromAsset('assets/images/from_marker.png', 80);

    destinationIcon = await BitmapDescriptor.bytes(icon2);
    setState(() {});
    return Future.value(true);
  }

  bool showErrorUI = false;

  @override
  void initState() {
    var location = Provider.of<LocationProvider>(context, listen: false);
    var user = Provider.of<UserProvider>(context, listen: false);

    UserServices()
        .fetchUpdatedData(user.getUserDetails()!.docId.toString())
        .then((value) {
      if (location.getCurrentLocation() != null && value.lat != null) {

        // log((value.lat!.toStringAsFixed(2)).toString());
        // log((location.getCurrentLocation()!.latitude.toStringAsFixed(2))
        //     .toString());
        // log((location.getCurrentLocation()!.longitude.toStringAsFixed(2))
        //     .toString());
        if (value.lat!.toStringAsFixed(2) ==
            location.getCurrentLocation()!.latitude.toStringAsFixed(2)) {
          lat = location.getCurrentLocation()!.latitude;
          lng = location.getCurrentLocation()!.longitude;

          setState(() {});
          markers.addAll([
            Marker(
              markerId: const MarkerId('2'),
              position: LatLng(lat, lng),
            ),
          ]);
          setState(() {});
        } else {
          LocationHelper().determinePosition().then((value) async {
            lat = value.latitude;
            lng = value.longitude;
            location.saveCurrentLocation(value);
            UserServices()
                .updateLocation(
                    model: RiderModel(
                        docId: user.getUserDetails()!.docId.toString(),
                        lat: value.latitude,
                        lng: value.longitude))
                .then((value) async {
              await UserServices()
                  .fetchUpdatedData(user.getUserDetails()!.docId.toString())
                  .then((data) {
                user.saveUserDetails(data);
              });
            });

            setState(() {});
            markers.addAll([
              Marker(
                markerId: const MarkerId('2'),
                position: LatLng(value.latitude, value.longitude),
              ),
            ]);
            setState(() {});
          });
        }
      } else {
        try {
          LocationHelper().determinePosition().then((value) async {
            lat = value.latitude;
            lng = value.longitude;
            location.saveCurrentLocation(value);
            UserServices()
                .updateLocation(
                    model: RiderModel(
                        docId: user.getUserDetails()!.docId.toString(),
                        lng: value.longitude,
                        lat: value.latitude))
                .then((value) async {
              await UserServices()
                  .fetchUpdatedData(user.getUserDetails()!.docId.toString())
                  .then((data) {
                user.saveUserDetails(data);
              });
            });

            setState(() {});
            markers.addAll([
              Marker(
                markerId: const MarkerId('2'),
                position: LatLng(value.latitude, value.longitude),
              ),
            ]);
            setState(() {});
          }).onError((error, stackTrace) {
            lat = -1;
            showErrorUI = true;
            setState(() {});
          });
        } catch (e) {
          getFlushBar(context, title: e.toString());
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(markers.length);

    return lat == 0
        ? Center(
            child: ProcessingWidget(),
          )
        : showErrorUI
            ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          "Kindly enable location permission in order to continue".tr(),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              )

            : SafeArea(
              child: Scaffold(
                  body: Stack(children: [
                    GoogleMap(
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                      mapToolbarEnabled: false,
                      myLocationEnabled: true,
                      markers: markers,
                      polylines: _polylines,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(lat, lng),
                        tilt: 30.440717697143555,
                        zoom: 16.4746,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                    SlidingUpPanel(
                      minHeight: 250,
                      maxHeight: 250,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      panel: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              alignment: Alignment.center,
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
                            HomeField(
                                svg: 'assets/svg/pickup_icon.svg',
                                hint: 'Enter your pickup location'.tr(),
                                controller: _pickUpController,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlacePicker(
                                        apiKey: Platform.isAndroid
                                            ? "AIzaSyAuJYLmzmglhCpBYTn0BjbJhjWYg0fPEEA"
                                            : "YOUR IOS API KEY",
                                        onPlacePicked: (result) {
                                          _pickUpController =
                                              TextEditingController(
                                                  text: result.formattedAddress
                                                      .toString());
                                          fromResult = result;
                                          setState(() {});

                                          Navigator.of(context).pop();
                                        },
                                        initialPosition: LatLng(lat, lng),
                                        useCurrentLocation: true,
                                        autocompleteLanguage: "en", // ya "ur" (for Urdu)
                                        region: "PK",  // **Important: Restrict search to Pakistan**
                                        resizeToAvoidBottomInset:
                                            false, // only works in page mode, less flickery, remove if wrong offsets
                                      ),
                                    ),
                                  );
                                },
                                inputType: TextInputType.text),
                            const SizedBox(
                              height: 18,
                            ),
                            HomeField(
                                svg: 'assets/svg/location_icon.svg',
                                hint: 'Where you want to go?'.tr(),
                                controller: _dropLocationController,
                                onTap: () {
                                  if (fromResult == null) {
                                    getFlushBar(context,
                                        title:
                                            "Kindly select your pickup location first.".tr());
                                    return;
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlacePicker(
                                        apiKey: Platform.isAndroid
                                            ? "AIzaSyAuJYLmzmglhCpBYTn0BjbJhjWYg0fPEEA"
                                            : "YOUR IOS API KEY",
                                        autocompleteLanguage: "en", // ya "ur" (for Urdu)
                                        region: "PK",
                                        onPlacePicked: (result) {
                                          _dropLocationController =
                                              TextEditingController(
                                                  text: result.formattedAddress
                                                      .toString());
                                          toResult = result;
                                          setState(() {});
                                          setPolylines(
                                            sourceLat: fromResult!
                                                .geometry!.location.lat
                                                .toDouble(),
                                            sourceLng: fromResult!
                                                .geometry!.location.lng
                                                .toDouble(),
                                            destLat: result.geometry!.location.lat
                                                .toDouble(),
                                            destLng: result.geometry!.location.lng
                                                .toDouble(),
                                          );
                                          setSourceAndDestinationIcons()
                                              .then((value) {
                                            markers.addAll([
                                              Marker(
                                                  markerId: const MarkerId('1'),
                                                  position: LatLng(
                                                    fromResult!
                                                        .geometry!.location.lat
                                                        .toDouble(),
                                                    fromResult!
                                                        .geometry!.location.lng
                                                        .toDouble(),
                                                  ),
                                                  icon: sourceIcon!),
                                              Marker(
                                                  markerId: const MarkerId('2'),
                                                  position: LatLng(
                                                    result.geometry!.location.lat
                                                        .toDouble(),
                                                    result.geometry!.location.lng
                                                        .toDouble(),
                                                  ),
                                                  icon: destinationIcon!),
                                            ]);
                                          });

                                          Navigator.of(context).pop();
                                        },
                                        initialPosition: LatLng(lat, lng),
                                        useCurrentLocation: true,
                                        resizeToAvoidBottomInset:
                                            false, // only works in page mode, less flickery, remove if wrong offsets
                                      ),
                                    ),
                                  );
                                },
                                inputType: TextInputType.text),
                            const SizedBox(
                              height: 18,
                            ),
                            AppButton(
                                onPressed: () {
                                  if (_pickUpController.text.isEmpty) {
                                    getFlushBar(context,
                                        title:
                                            "Kindly select your pickup location.".tr());
                                    return;
                                  }
                                  if (_dropLocationController.text.isEmpty) {
                                    getFlushBar(context,
                                        title:
                                            "Kindly select your drop off location.".tr());
                                    return;
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SelectCarView(
                                                from: _pickUpController.text,
                                                to: _dropLocationController.text,
                                                fromLat: fromResult!
                                                    .geometry!.location.lat,
                                                fromLng: fromResult!
                                                    .geometry!.location.lng,
                                                toLat: toResult!
                                                    .geometry!.location.lat,
                                                toLng: toResult!
                                                    .geometry!.location.lng,
                                              )));
                                },
                                btnLabel: "Select Vehicle".tr())
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
            );
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
