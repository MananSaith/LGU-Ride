import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';
import 'layout/body.dart';

class DriverDetailsView extends StatelessWidget {
  final RideModel rideModel;

  const DriverDetailsView({Key? key, required this.rideModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: RiderServices().fetchUserData(rideModel.riderId.toString()),
        initialData: RiderModel(),
        builder: (context, child) {
          RiderModel model = context.watch<RiderModel>();
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                "Driver Detail".tr(),
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: model.docId == null
                ? Center(
                    child: ProcessingWidget(),
                  )
                : DriverDetailsBody(
                    model: model,
                  ),
            bottomNavigationBar: model.docId == null
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatView(
                                          model: rideModel,
                                        )));
                          },
                          icon: 'assets/svg/message.svg',
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        RoundButton(
                          onPressed: () {
                            callHelper(model.phoneNumber.toString());
                          },
                          icon: 'assets/svg/telephone_icon.svg',
                        ),
                      ],
                    ),
                  ),
          );
        });
  }
}
