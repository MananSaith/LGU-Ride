
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class TripDetailsBody extends StatefulWidget {
  @override
  State<TripDetailsBody> createState() => TripDetailsBodyState();
}

class TripDetailsBodyState extends State<TripDetailsBody> {
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
        await getBytesFromAsset('assets/images/marker.png', 100);

    destinationIcon = await BitmapDescriptor.fromBytes(icon1);
    setState(() {});
    return Future.value(true);
  }

  @override
  void initState() {
    setSourceAndDestinationIcons().then((value) {
      markers.addAll([
        Marker(
            markerId: const MarkerId('2'),
            position: const LatLng(37.42796133580664, -122.085749655962),
            icon: destinationIcon!),
        // Polyline(polylineId: )
      ]);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(markers.length);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(children: [
            const RideSelectionCard(),
            const SizedBox(height:8,),
            SizedBox(
              height: 200,
              child: GoogleMap(
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                mapToolbarEnabled: false,
                markers: markers,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            const SizedBox(height:8,),
            Card(
              elevation:0.5,
              shape:OutlineInputBorder(
                borderRadius:BorderRadius.circular(8),borderSide:BorderSide.none
              ),
              child: SizedBox(
                height:87,
                width:MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "\$56.00".tr(),
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text: "Payment made successfully by cash".tr(),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.contentDisabled,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height:8,),
            Card(
              elevation:0.5,
              shape:OutlineInputBorder(
                  borderRadius:BorderRadius.circular(8),borderSide:BorderSide.none
              ),
              child: SizedBox(
                height:87,
                width:MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:18.0),
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "14 min".tr(),
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                          CustomText(
                            text: "Time".tr(),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.contentDisabled,
                          ),
                        ],
                      ),
                      Container(width:1,color:AppColors.contentDisabled,),
                      Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "10 km".tr(),
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                          CustomText(
                            text: "Distance".tr(),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.contentDisabled,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height:8,),
            Card(
              elevation:0.5,
              shape:OutlineInputBorder(
                  borderRadius:BorderRadius.circular(8),borderSide:BorderSide.none
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                     TripRowWidget(title: 'Date & Time'.tr(), value: 'Jul 10 2022'.tr(),),
                    const SizedBox(height:18,),
                     TripRowWidget(title: 'Payment Method', value: 'Credit Card'.tr(),),
                    const SizedBox(height:18,),
                     TripRowWidget(title: 'Service Type'.tr(), value: 'E - Class'.tr(),),
                    const SizedBox(height:18,),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                      CustomText(text: 'Your Ratted'.tr(),fontSize:16,fontWeight:FontWeight.w300,),
                      SvgPicture.asset('assets/svg/rating.svg')
                    ],),
                    const SizedBox(height:18,),
                     TripRowWidget(title: 'Trip Fare'.tr(), value: '\$48.00'.tr(),),
                    const SizedBox(height:18,),
                     TripRowWidget(title: '+Tax'.tr(), value: '\$2.00'.tr(),),
                    const SizedBox(height:18,),
                     TripRowWidget(title: '+Tolls'.tr(), value: '\$6.00',),
                    const SizedBox(height:18,),
             ] ),
              ))

          ]),
        ),
      ),
    );
  }
}
