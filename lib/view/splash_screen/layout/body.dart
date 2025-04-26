
import 'package:riding_app/utils/app_imports.dart';
import 'package:flutter/material.dart';


class SplashBody extends StatefulWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  String status = "";

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      // await SharedPreferences.getInstance().then((prefs) async {
      //   if (prefs.getString('TYPE') != null) {
      //     if (prefs.getString('TYPE') == "USER") {
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (context) => OnBoardingView()));
      //     } else if (prefs.getString('TYPE') == "RIDER") {
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (context) => OnBoardingView()));
      //     }
      //   } else {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => const OnBoardingView()));
      //   }
      // });

      await SharedPreferences.getInstance().then((prefs) async {
        if (prefs.getString('TYPE') != null) {
          if (prefs.getString('TYPE') == "USER") {
            var userProvider =
                Provider.of<UserProvider>(context, listen: false);
            RiderModel model = riderModelFromJson(prefs.getString('USER_DATA')!);
            await UserServices()
                .fetchUpdatedData(model.docId.toString())
                .then((value) {
              userProvider.saveUserDetails(model);
              prefs.setString("USER_DATA", riderModelToJson(value));
              RideServices()
                  .getMyRides(userProvider.getUserDetails()!.docId.toString())
                  .then((value) {
                    log(value.length.toString());
                if (value.isNotEmpty) {
                  if (value[0].isPending == true) {
                    status = "SEARCHING";
                  } else if (value[0].isPending == false &&
                      value[0].isProcessed == true &&
                      value[0].isArrived == false &&
                      value[0].isCompleted == false &&
                      value[0].isCancelled == false) {
                    status = "ARRIVING";
                  } else if (value[0].isPending == false &&
                      value[0].isProcessed == true &&
                      value[0].isArrived == true &&
                      value[0].isCompleted == false &&
                      value[0].isCancelled == false) {
                    status = "START";
                  }
                  setState(() {

                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavBarView(
                                status: status,
                                model: value[0],
                              )));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavBarView(
                                status: "EMPTY",
                                model: RideModel(),
                              )));
                }
              });
            });
          } else if (prefs.getString('TYPE') == "RIDER") {
            var userProvider =
                Provider.of<UserProvider>(context, listen: false);
            RiderModel model =
                riderModelFromJson(prefs.getString('USER_DATA')!);
            await RiderServices()
                .fetchUpdateRiderData(model.docId.toString())
                .then((value) {
              userProvider.saveRiderData(model);
              prefs.setString("USER_DATA", riderModelToJson(value));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DriverHomeView()));
            });

            //   var userProvider =
            //   Provider.of<UserProvider>(context, listen: false);
            //   UserModel model = userModelFromJson(prefs.getString('USER_DATA')!);
            //   await TrainerServices()
            //       .fetchUpdatedUserData(model.docId.toString())
            //       .then((value) {
            //     userProvider.saveTrainerDetails(value);
            //     prefs.setString("USER_DATA", trainerModelToJson(value));
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const TrainerBottomBarView()));
            //   });
          }
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const OnBoardingView()));
        }
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/lgu_logo.png",
            height: 250,
            width: 250,
          ),
        ],
      ),
    );
  }
}
