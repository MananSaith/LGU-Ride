import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart' as LT;
import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class SearchingDrivingBody extends StatefulWidget {
  final String rideID;
  final String vehicleID;
  final String vehicleImage;

  const SearchingDrivingBody(
      {super.key,
      required this.rideID,
      required this.vehicleID,
      required this.vehicleImage});

  @override
  State<SearchingDrivingBody> createState() => SearchingDrivingBodyState();
}

class SearchingDrivingBodyState extends State<SearchingDrivingBody> {
  final Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers = {};

  Timer? _timer;

  Stream<RideModel>? rideStream;

  double lat = 0.0;
  double lng = 0.0;
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
    Uint8List? icon1;
    await NetworkAssetBundle(Uri.parse(widget.vehicleImage))
        .load(widget.vehicleImage)
        .then((value) {
      icon1 = value.buffer.asUint8List();
      setState(() {});
    });

    sourceIcon = await BitmapDescriptor.fromBytes(icon1!);

    setState(() {});
    return Future.value(true);
  }

  List<RiderModel> ridersList = [];

  getRiders() {
    var user = Provider.of<UserProvider>(context, listen: false);
    RiderServices()
        .fetchRiders(
            vehicleType: widget.vehicleID.toString(),
            cityID: user.getUserDetails()!.cityID.toString())
        .then((value) {
      markers.clear();
      value.map((e) {
        RideServices().sendRide(
            rideID: widget.rideID.toString(), driverID: e.docId.toString());
      }).toList();

      ridersList = value;
      setState(() {});
      if (ridersList.isNotEmpty) {
        ridersList.map((e) {
          markers.add(Marker(
              markerId: MarkerId(e.docId.toString()),
              icon: sourceIcon!,
              position: LatLng(
                e.lat == null ? 0.0 : e.lat!,
                e.lng == null ? 0.0 : e.lng!,
              )));
        }).toList();
      }
    });
  }

  @override
  void initState() {
    var user = Provider.of<UserProvider>(context, listen: false);
    lat = user.getUserDetails()!.lat!;
    lng = user.getUserDetails()!.lng!;
    setSourceAndDestinationIcons().then((value){
      setState(() {});

      getRiders();
      markers.addAll([
        Marker(
          markerId: const MarkerId('2'),
          position: LatLng(lat, lng),
        ),
      ]);
      setState(() {});
    });

print("initttttttttttttttttttttttttttt 1111111");
    RideServices().streamRideByID(widget.rideID.toString()).listen((event) {
      if (event.isProcessed == true) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DriverArrivingView(
                      rideID: widget.rideID.toString(),
                    )));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false);
    log(lat.toString());
    log(lng.toString());
    return lat == 0.0 || lng == 0.0
        ? Center(
            child: ProcessingWidget(),
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
                zoom: 12.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Positioned.fill(child: LT.Lottie.asset('assets/images/radar.json')),
            Positioned.fill(
              top: 100,
              child: Column(
                children: [
                  Container(
                      height: 61,
                      width: 61,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.primary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          "assets/svg/car_icon.svg",
                        ),
                      )),
                  Transform.translate(
                      offset: const Offset(0, -1),
                      child: SvgPicture.asset(
                        "assets/svg/polygon.svg",
                        color: AppColors.primary,
                      )),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomText(
                    text: "Searching Ride...".tr(),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomText(
                    text: "This may take a few seconds...".tr(),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                child: AppButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CancelRideView(
                                  riderID: "",
                                  rideID: widget.rideID.toString())));
                    },
                    btnLabel: "Cancel Ride".tr()),
              ),
            ),
          ]);
  }
}
