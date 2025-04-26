import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riding_app/utils/app_imports.dart';
class LogInBody extends StatefulWidget {
  LogInBody({Key? key}) : super(key: key);

  @override
  State<LogInBody> createState() => _LogInBodyState();
}

class _LogInBodyState extends State<LogInBody> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  LoginBusinessLogic data = LoginBusinessLogic();
  String status = "";
  bool isBiometricsAvailable = false;
  bool showBiometricButton = false;

  LocalAuthentication auth = LocalAuthentication();

  Future authenticate() async {
    try {
      return await auth.authenticate(
        localizedReason: 'Verify your identity.'.tr(),
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException {
      return false;
    }
  }

  checkBioMetric() async {
    isBiometricsAvailable = await auth.canCheckBiometrics;
    setState(() {});
  }

  @override
  void initState() {
    checkBioMetric();
    SharedPreferences.getInstance().then((value) {
      if (value.getBool('SHOW_USER_BIOMETRIC') == true) {
        showBiometricButton = true;
        setState(() {});
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthServices>(context);
    return LoadingOverlay(
      isLoading: auth.status == Status.Authenticating,
      progressIndicator: ProcessingWidget(),
      color: Colors.transparent,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Login to \nyour account".tr(),
                //   style: AppColors.kHeadingStyle,
                // ),
                context.locale.languageCode != "en"
                    ? Text(
                  "Login to your account".tr(),
                  style: AppColors.kHeadingStyle,
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login to ".tr(),
                      style: AppColors.kHeadingStyle,
                    ),
                    Text(
                      "your account".tr(),
                      style: AppColors.kHeadingStyle,
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                    isSecure: false,
                    controller: _emailController,
                    icon: "assets/svg/email_icon.svg",
                    text: 'Email'.tr(),
                    onTap: () {},
                    keyBoardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 18,
                ),
                CustomTextField(
                  controller: _passwordController,
                  icon: "assets/svg/lock_icon.svg",
                  text: 'Password'.tr(),
                  onTap: () {},
                  keyBoardType: TextInputType.text,
                  isPassword: true,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PassengerForgotPasswordView()));
                      },
                      child: CustomText(
                        text: 'Forgot Password?'.tr(),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                AppButton(
                    onPressed: () {
                      if (_emailController.text.isEmpty) {
                        getFlushBar(context,
                            title: "Email cannot be empty.".tr());
                        return;
                      }

                      if (_passwordController.text.isEmpty) {
                        getFlushBar(context,
                            title: "Password cannot be empty.".tr());
                        return;
                      }

                      loginUser(
                          context: context,
                          data: data,
                          email: _emailController.text,
                          password: _passwordController.text);
                    },
                    btnLabel: "Log in".tr()),
                const SizedBox(
                  height: 30,
                ),
                if (isBiometricsAvailable && showBiometricButton)
                  SizedBox(
                    height: 10,
                  ),
                if (isBiometricsAvailable && showBiometricButton)
                  InkWell(
                      onTap: () async {
                        try {
                          bool isAuthenticated = await authenticate();
                          if (isAuthenticated) {
                            await SharedPreferences.getInstance()
                                .then((prefs) async {
                              if (prefs.getString('TYPE') != null) {
                                if (prefs.getString('TYPE') == "USER") {
                                  var userProvider = Provider.of<UserProvider>(
                                      context,
                                      listen: false);
                                  RiderModel model = riderModelFromJson(
                                      prefs.getString('USER_DATA')!);
                                  await UserServices()
                                      .fetchUpdatedData(model.docId.toString())
                                      .then((value) {
                                    userProvider.saveUserDetails(model);
                                    prefs.setString(
                                        "USER_DATA", riderModelToJson(value));
                                    RideServices()
                                        .getMyRides(userProvider
                                            .getUserDetails()!
                                            .docId
                                            .toString())
                                        .then((value) {
                                      log(value.length.toString());
                                      if (value.isNotEmpty) {
                                        if (value[0].isPending == true) {
                                          status = "SEARCHING";
                                        } else if (value[0].isPending ==
                                                false &&
                                            value[0].isProcessed == true &&
                                            value[0].isArrived == false &&
                                            value[0].isCompleted == false &&
                                            value[0].isCancelled == false) {
                                          status = "ARRIVING";
                                        } else if (value[0].isPending ==
                                                false &&
                                            value[0].isProcessed == true &&
                                            value[0].isArrived == true &&
                                            value[0].isCompleted == false &&
                                            value[0].isCancelled == false) {
                                          status = "START";
                                        }
                                        setState(() {});
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BottomNavBarView(
                                                      status: status,
                                                      model: value[0],
                                                    )));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BottomNavBarView(
                                                      status: "EMPTY",
                                                      model: RideModel(),
                                                    )));
                                      }
                                    });
                                  });
                                } else if (prefs.getString('TYPE') == "RIDER") {
                                  getFlushBar(context,
                                      title:
                                          "Sorry! You cannot login as a user with driver account."
                                              .tr());
                                }
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OnBoardingView()));
                              }
                            });
                          }
                        } catch (e) {
                          getFlushBar(context, title: e.toString());
                        }
                      },
                      child: Container(
                          height: 44,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xff1C1C1C)),
                          child: Platform.isAndroid
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3.0),
                                  child: Image.asset(
                                    'assets/images/fingerprint.png',
                                    color: Colors.white,
                                  ),
                                )
                              : Image.asset(
                                  'assets/images/face-id.png',
                                  color: Colors.white,
                                ))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginUser(
      {required BuildContext context,
      required LoginBusinessLogic data,
      required String email,
      required String password}) async {
    var auth = Provider.of<AuthServices>(context, listen: false);

    data
        .loginUserLogic(context, email: email, password: password)
        .then((val) async {
      if (auth.status == Status.Authenticated) {
        await SharedPreferences.getInstance().then((prefs) async {
          if (prefs.getString('TYPE') != null) {
            if (prefs.getString('TYPE') == "USER") {
              var userProvider =
                  Provider.of<UserProvider>(context, listen: false);
              RiderModel model =
                  riderModelFromJson(prefs.getString('USER_DATA')!);
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
                    setState(() {});
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
              getFlushBar(context,
                  title:
                      "Sorry! You cannot login as a user with driver account."
                          .tr());
            }
          }
        });
      } else {
        showErrorDialog(context,
            message: Provider.of<ErrorString>(context, listen: false)
                .getErrorString().tr());
      }
    });
  }
}
