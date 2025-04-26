import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class CancelRideBody extends StatefulWidget {
  final String rideID;
  final String riderID;
  final bool isRider;

  CancelRideBody(
      {Key? key,
      required this.rideID,
      required this.riderID,
      required this.isRider})
      : super(key: key);

  @override
  State<CancelRideBody> createState() => _CancelRideBodyState();
}

class _CancelRideBodyState extends State<CancelRideBody> {
  bool isLoading = false;

  List<String> reasons = [
    "Captain ia too far away".tr(),
    "I don't need a ride anymore.".tr(),
    "Captain asked me to cancel.".tr(),
    "I found another ride.".tr(),
    "Car wasn't suitable.".tr(),
    "Captain had low rating.".tr(),
    "I wasn't ready.".tr(),
    "I booked by mistake".tr(),
    "Captain not moving.".tr(),
    "I want to change my booking details".tr(),
    "I couldn't contact the captain.".tr(),
    "Captain couldn't find my location.".tr(),
    "Other".tr(),
  ];
  List<String> riderReasons = [
    "Passenger is too far away.".tr(),
    "Passenger is not responding.".tr(),
    "Passenger asked me to cancel.".tr(),
    "Passenger had low rating.".tr(),
    "I wasn't ready.".tr(),
    "Other".tr(),
  ];

  String selectedReason = "";
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: const ProcessingWidget(),
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Please select the reason of cancellation.".tr(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Help us understand what's happening with this ride. How would you describe it?".tr(),
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (!widget.isRider)
              ...reasons
                  .map((e) => Column(
                        children: [
                          ListTile(
                            selected: selectedReason == e,
                            selectedTileColor:
                                AppColors.primary.withOpacity(0.3),
                            onTap: () {
                              selectedReason = e;
                              setState(() {});
                            },
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 15,
                            ),
                            title: Text(
                              e.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Divider(
                            height: 0,
                          )
                        ],
                      ))
                  .toList()
            else
              ...riderReasons
                  .map((e) => Column(
                        children: [
                          ListTile(
                            selected: selectedReason == e,
                            selectedTileColor:
                                AppColors.primary.withOpacity(0.3),
                            onTap: () {
                              selectedReason = e;
                              setState(() {});
                            },
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 15,
                            ),
                            title: Text(
                              e.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Divider(
                            height: 0,
                          )
                        ],
                      ))
                  .toList(),
            SizedBox(
              height: 10,
            ),
            if (selectedReason == "Other".tr())
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: CustomTextField(
                  text: 'Kindly provide reason...'.tr(),
                  keyBoardType: TextInputType.text,
                  isPassword: false,
                  isSecure: false,
                  controller: controller,
                  onTap: () {},
                  icon: '',
                ),
              ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: AppButton(
                btnLabel: 'Submit Report'.tr(),
                onPressed: () async {
                  if (selectedReason == "") {
                    getFlushBar(context, title: "Kindly select reason.".tr());
                    return;
                  }
                  if (selectedReason == "Other".tr()) {
                    if (controller.text.isEmpty) {
                      getFlushBar(context, title: "Kindly write reason.".tr());
                      return;
                    }
                  }
                  isLoading = true;
                  setState(() {});
                  try {
                    await RideServices()
                        .cancelRide(
                            rideID: widget.rideID.toString(),
                            riderID: widget.riderID.toString(),
                            reason: selectedReason,
                            userID: widget.isRider
                                ? user.getRiderDetails()!.docId.toString()
                                : user.getUserDetails()!.docId.toString())
                        .then((value) {
                      RiderServices()
                          .updateBusyStatus(
                              model: RiderModel(
                                  docId: widget.riderID.toString(),
                                  isBusy: false,
                                  rideID: ""))
                          .then((value) {
                        showNavigationDialog(context,
                            message: "Ride has been cancelled successfully.".tr(),
                            buttonText: "Okay".tr(), navigation: () {
                          if (widget.isRider) {
                            RiderServices().updateBusyStatus(
                                model: RiderModel(
                                    docId: user
                                        .getRiderDetails()!
                                        .docId
                                        .toString(),
                                    rideID: "",
                                    isBusy: false));
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DriverHomeView()),
                                (route) => false);
                          } else {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavBarView()),
                                (route) => false);
                          }
                        },
                            secondButtonText: "secondButtonText",
                            showSecondButton: false);
                      });
                    });
                  } catch (e) {
                    getFlushBar(context, title: e.toString());
                  } finally {
                    isLoading = false;
                    setState(() {});
                  }
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
