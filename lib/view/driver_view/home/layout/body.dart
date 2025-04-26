
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';
import 'package:flutter/services.dart';


class DriverHomeBody extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const DriverHomeBody({super.key, required this.scaffoldKey});

  @override
  State<DriverHomeBody> createState() => DriverHomeBodyState();
}

class DriverHomeBodyState extends State<DriverHomeBody> {
  double lat = 0.0;
  double lng = 0.0;
  BitmapDescriptor? destinationIcon;
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    var location = Provider.of<LocationProvider>(context, listen: false);
    var user = Provider.of<UserProvider>(context, listen: false);
    LocationHelper().determinePosition().then((value) async {
      lat = value.latitude;
      lng = value.longitude;
      location.saveCurrentLocation(value);
      RiderServices().updateLocation(
          model: RiderModel(
              lat: lat,
              lng: lng,
              docId: user.getRiderDetails()!.docId.toString()));

      setState(() {});
      markers.addAll([
        Marker(
          markerId: const MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
        ),
      ]);
      setState(() {});
    });

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

  Future setSourceAndDestinationIcons() async {
    final Uint8List icon1 =
        await getBytesFromAsset('assets/images/p_marker.png', 120);

    destinationIcon = await BitmapDescriptor.fromBytes(icon1);
    setState(() {});
    return Future.value(true);
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    print(markers.length);
    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: ProcessingWidget(),
      color: Colors.transparent,
      child: StreamProvider.value(
          value: RiderServices()
              .fetchUserData(user.getRiderDetails()!.docId.toString()),
          initialData: RiderModel(),
          builder: (context, child) {
            RiderModel riderModel = context.watch<RiderModel>();

            return riderModel.docId == null
                ? Center(
                    child: ProcessingWidget(),
                  )
                : lat == 0
                    ? Center(
                        child: ProcessingWidget(),
                      )
                    : StreamProvider.value(
                        value: RideServices().streamActiveRides(
                            user.getRiderDetails()!.docId.toString()),
                        initialData: [RideModel()],
                        builder: (context, child) {
                          List<RideModel> networkList =
                              context.watch<List<RideModel>>();
                          List<RideModel> rideList = [];
                          if (networkList.isNotEmpty) {
                            if (networkList[0].docId != null) {
                              networkList.map((e) {
                                if (!e.rejectedUsers!.contains(
                                    user.getRiderDetails()!.docId.toString())) {
                                  rideList.add(e);
                                }
                              }).toList();
                            }
                          }

                          return Stack(children: [
                            GoogleMap(
                              zoomControlsEnabled: false,
                              mapType: MapType.normal,
                              mapToolbarEnabled: false,
                              myLocationEnabled: false,
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
                            SwitchWidget(
                              model: riderModel,
                              onPressed: () {
                                widget.scaffoldKey.currentState?.openDrawer();
                              },
                            ),
                            Positioned(
                              top: 100,
                              left: 0.0,
                              right: 0.0,
                              bottom: 0.0,
                              child: SizedBox(
                                height: 100,
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: rideList.length,
                                    itemBuilder: (context, i) {
                                      return RideDetailsCard(
                                        model: rideList[i],
                                        mainContext: context,
                                        onReject: () async {
                                          isLoading = true;
                                          setState(() {});
                                          try {
                                            await RideServices()
                                                .rejectRide(
                                                    rideID: rideList[i]
                                                        .docId
                                                        .toString(),
                                                    model:
                                                        user.getRiderDetails()!)
                                                .then((value) {});
                                          } catch (e) {
                                            getFlushBar(context,
                                                title: e.toString());
                                          } finally {
                                            isLoading = false;
                                            setState(() {});
                                          }
                                        },
                                        onAccept: () async {
                                          isLoading = true;
                                          setState(() {});
                                          try {
                                            RideServices()
                                                .getRideByID(rideList[i]
                                                    .docId
                                                    .toString())
                                                .then((value) async {
                                              if (value.isPending == true) {
                                                await RideServices()
                                                    .acceptRide(
                                                        rideID: rideList[i]
                                                            .docId
                                                            .toString(),
                                                        model: user
                                                            .getRiderDetails()!)
                                                    .then((value) async {
                                                  await RiderServices()
                                                      .updateBusyStatus(
                                                          model: RiderModel(
                                                              docId: user
                                                                  .getRiderDetails()!
                                                                  .docId
                                                                  .toString(),
                                                              rideID: rideList[
                                                                      i]
                                                                  .docId
                                                                  .toString(),
                                                              isBusy: true));
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PickupView(
                                                                model:
                                                                    rideList[i],
                                                              )));
                                                });
                                              } else {
                                                getFlushBar(context,
                                                    title:
                                                        "Sorry! Ride has been booked by someone else.".tr());
                                              }
                                            });
                                          } catch (e) {
                                            getFlushBar(context,
                                                title: e.toString());
                                          } finally {
                                            isLoading = false;
                                            setState(() {});
                                          }
                                        },
                                      );
                                    }),
                              ),
                            )
                          ]);
                        });
          }),
    );
  }
}
