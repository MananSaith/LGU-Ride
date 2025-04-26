import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class SwitchWidget extends StatefulWidget {
  final RiderModel model;

  SwitchWidget({Key? key, required this.onPressed, required this.model})
      : super(key: key);
  VoidCallback onPressed;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return StreamProvider.value(
      value: RiderServices().fetchUserData(widget.model.docId.toString()),
      initialData: RiderModel(),
      builder: (context,child) {
        RiderModel _riderModel = context.watch<RiderModel>();
        return Padding(
          padding: const EdgeInsets.only(right: 18.0, left: 18, top: 34),
          child: Card(
            color: Colors.white,
              elevation: 2,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: widget.onPressed,
                          icon: SvgPicture.asset('assets/svg/drawer_icon.svg')),
                      CustomText(
                        text: widget.model.isOnline == true ? "Online".tr() : "Offline".tr(),
                        fontWeight: FontWeight.w600,
                      ),
                      Row(
                        children: [
                          if (_riderModel.isBusy == true)
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PickupView(model: RideModel(docId: widget.model.rideID.toString()))));
                                },
                                icon: Icon(
                                  Icons.car_crash_sharp,
                                  color: AppColors.primary,
                                )),
                          Transform.scale(
                            scale: 0.6,
                            transformHitTests: false,
                            child: CupertinoSwitch(
                                activeColor: AppColors.primary,
                                trackColor: AppColors.contentDisabled,
                                value: widget.model.isOnline == true,
                                onChanged: (value) {
                                  RiderServices()
                                      .updateOnlineStatus(
                                          model: RiderModel(
                                              docId: widget.model.docId.toString(),
                                              isOnline: value))
                                      .then((value) {
                                    RiderServices()
                                        .fetchUpdateRiderData(
                                            widget.model.docId.toString())
                                        .then((value) {
                                      user.saveRiderData(value);
                                    });
                                  });
                                }),
                          ),
                        ],
                      )
                    ]),
              )),
        );
      }
    );
  }
}
