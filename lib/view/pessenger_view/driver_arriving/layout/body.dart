
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riding_app/utils/app_imports.dart';

class DriverArrivingBody extends StatefulWidget {
  final String rideID;

  const DriverArrivingBody({Key? key, required this.rideID}) : super(key: key);

  @override
  State<DriverArrivingBody> createState() => DriverArrivingBodyState();
}

class DriverArrivingBodyState extends State<DriverArrivingBody> {
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? destinationIcon;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Set<Marker> markers = {};
  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

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
        await getBytesFromAsset('assets/images/driver_marker.png', 240);

    destinationIcon = await BitmapDescriptor.fromBytes(icon1);
    setState(() {});
    return Future.value(true);
  }

  double lat = 0.0;
  double lng = 0.0;

  @override
  void initState() {
    var user = Provider.of<UserProvider>(context, listen: false);
    lat = user.getUserDetails()!.lat!;
    lng = user.getUserDetails()!.lng!;
    setState(() {});
    markers.addAll([
      Marker(
        markerId: const MarkerId('2'),
        position: LatLng(lat, lng),
      ),
    ]);
    setState(() {});

    RideServices().streamRideByID(widget.rideID.toString()).listen((event) {
      if (event.isArrived == true) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RideStartView(
                      rideID: widget.rideID.toString(),
                    )));
      }
    });

    super.initState();
  }

  bool isFirstLoad = true;

  @override
  Widget build(BuildContext context) {
    print(markers.length);
    return lat == 0.0
        ? Center(
            child: ProcessingWidget(),
          )
        : StreamProvider.value(
            value: RideServices().streamRideByID(widget.rideID.toString()),
            initialData: RideModel(),
            builder: (context, child) {
              RideModel rideModel = context.watch<RideModel>();

              if (isFirstLoad) {
                if (rideModel.docId != null) {
                  ChatServices().createGroup(context,
                      model: GroupModel(
                        dealId: rideModel.docId.toString(),
                        lastMessage: "",
                        name: "Group Chat".tr(),
                        users: [
                          rideModel.userId.toString(),
                          rideModel.riderId.toString()
                        ],
                        docId: rideModel.docId.toString(),
                        groupMember: [
                          GroupMemberModel(
                              userId: rideModel.userId.toString(),
                              time: Timestamp.now()),
                          GroupMemberModel(
                              userId: rideModel.riderId.toString(),
                              time: Timestamp.now()),
                        ],
                      ));
                }

                isFirstLoad = false;
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
                                  markers: markers,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(lat, lng),
                                    tilt: 30.440717697143555,
                                    zoom: 16.4746,
                                  ),
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _controller.complete(controller);
                                  },
                                ),
                                SlidingUpPanel(
                                  minHeight: 280,
                                  maxHeight: 280,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12)),
                                  panel: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              text: "Driver is arriving...".tr(),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            CustomText(
                                                text: "3 min".tr(),
                                                color:
                                                    AppColors.contentDisabled,
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
                                          height: 34,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RoundButton(
                                              icon:
                                                  'assets/svg/cancel_icon.svg',
                                              customHeight : 18,
                                              customWidth: 18,
                                              bgColor: AppColors.kAuthColor,
                                              svgColor: Colors.white,
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CancelRideView(
                                                              rideID: rideModel
                                                                  .docId
                                                                  .toString(),
                                                              riderID: rideModel.riderId.toString(),
                                                            )));
                                              },
                                            ),
                                            const SizedBox(
                                              width: 18,
                                            ),
                                            RoundButton(
                                              icon: 'assets/svg/message.svg',
                                              bgColor:
                                                  AppColors.primary,
                                              svgColor: Colors.white,
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatView(
                                                                model:
                                                                    rideModel)));
                                              },
                                            ),
                                            const SizedBox(
                                              width: 18,
                                            ),
                                            RoundButton(
                                              icon:
                                                  'assets/svg/telephone_icon.svg',
                                              bgColor:
                                                  AppColors.primary,
                                              svgColor: Colors.white,
                                              onPressed: () {
                                                callHelper(rideModel
                                                    .riderPhoneNumber
                                                    .toString());
                                              },
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                      ),
                    );
            });
  }
}
