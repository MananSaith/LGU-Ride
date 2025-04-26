
import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class SignUpBody extends StatefulWidget {
  SignUpBody({Key? key}) : super(key: key);

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isLoading = false;
  List<CityModel> cityList = [];
  CityModel? _selectedCity;

  getCities() async {
    _selectedCity = null;
    cityList.clear();
    setState(() {});
    await CityServices().fetchCities().then((value) {
      cityList.addAll(value);
      setState(() {});
    });
  }

  @override
  void initState() {
    getCities();
    super.initState();
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    SignUpBusinessLogic signUp = Provider.of<SignUpBusinessLogic>(context);
    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: const ProcessingWidget(),
      color: Colors.transparent,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Create your \nAccount".tr(),
                //   style: AppColors.kHeadingStyle,
                // ),
                context.locale.languageCode != "en"
                    ? Text(
                        "Create your Account".tr(),
                        style: AppColors.kHeadingStyle,
                      )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create your ".tr(),
                            style: AppColors.kHeadingStyle,
                          ),
                          Text(
                            "Account".tr(),
                            style: AppColors.kHeadingStyle,
                          )
                        ],
                      ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                    isSecure: false,
                    controller: _nameController,
                    icon: "assets/svg/person_icon.svg",
                    text: 'Full Name'.tr(),
                    onTap: () {},
                    keyBoardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 18,
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
                    isSecure: false,
                    controller: _phoneNumberController,
                    icon: "assets/svg/phone.svg",
                    text: 'Phone Number'.tr(),
                    onTap: () {},
                    keyBoardType: TextInputType.number),
                const SizedBox(
                  height: 18,
                ),
                _getCityDropDown(),
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
                  height: 18,
                ),
                CustomTextField(
                  icon: "assets/svg/lock_icon.svg",
                  text: 'Confirm Password'.tr(),
                  onTap: () {},
                  controller: _confirmPasswordController,
                  keyBoardType: TextInputType.text,
                  isPassword: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          isChecked = !isChecked;
                          setState(() {});
                        },
                        icon: Icon(isChecked
                            ? Icons.check_box
                            : Icons.check_box_outline_blank)),

                    Expanded(
                      child: new RichText(
                        text: new TextSpan(
                          text: 'By creating account you need to accept our '
                              .tr(),
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            new TextSpan(
                                text: 'Terms & Conditions'.tr(),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TermsAndCondition()));
                                  },
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                            new TextSpan(text: ' & '.tr()),
                            new TextSpan(
                                text: 'Privacy Policy.'.tr(),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PrivacyPolicyView()));
                                  },
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),

                    // Expanded(
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => TermsAndCondition()));
                    //     },
                    //     child: Text(
                    //         "By creating account you need to accept or terms and conditions.".tr()),
                    //   ),
                    // )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                AppButton(
                    onPressed: () {
                      if (_nameController.text.isEmpty) {
                        getFlushBar(context,
                            title: 'Name cannot be empty.'.tr());
                        return;
                      }
                      if (_emailController.text.isEmpty) {
                        getFlushBar(context,
                            title: 'Email cannot be empty.'.tr());
                        return;
                      }
                      if (_phoneNumberController.text.isEmpty) {
                        getFlushBar(context,
                            title: 'Phone Number cannot be empty.'.tr());
                        return;
                      }
                      if (_phoneNumberController.text.length != 11) {
                        getFlushBar(context,
                            title: 'Kindly enter valid phone number.'.tr());
                        return;
                      }

                      if (_selectedCity == null) {
                        getFlushBar(context,
                            title: "Kindly select your city.".tr());
                        return;
                      }
                      if (_passwordController.text.isEmpty) {
                        getFlushBar(context,
                            title: 'Password cannot be empty.'.tr());
                        return;
                      }
                      if (_confirmPasswordController.text.isEmpty) {
                        getFlushBar(context,
                            title: 'Confirm Password cannot be empty.'.tr());
                        return;
                      }
                      if (_confirmPasswordController.text !=
                          _passwordController.text) {
                        getFlushBar(context,
                            title: 'Password does not match.'.tr());
                        return;
                      }
                      if (isChecked == false) {
                        getFlushBar(context,
                            title:
                                "Kindly accept our terms and conditions.".tr());
                        return;
                      }
                      _signUpUser(context: context, signUp: signUp);
                    },
                    btnLabel: "Create Account".tr()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signUpUser({
    required BuildContext context,
    required SignUpBusinessLogic signUp,
  }) async {
    isLoading = true;
    setState(() {});

    await signUp
        .registerNewUser(
      email: _emailController.text,
      password: _passwordController.text,
      userModel: RiderModel(
          email: _emailController.text,
          name: _nameController.text,
          cityID: _selectedCity!.docId.toString(),
          phoneNumber: _phoneNumberController.text),
      context: context,
    )
        .then((user) async {
      isLoading = false;
      setState(() {});
      Provider.of<AppState>(context, listen: false)
          .stateStatus(StateStatus.IsFree);
      if (signUp.status == SignUpStatus.Registered) {
        showNavigationDialog(context,
            message:
                "Thanks for registration on our system. You will receive a link in your email inbox. Kindly activate your email first in order to continue."
                    .tr(),
            buttonText: "Go to Login".tr(), navigation: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PassengerLogInView()));
        }, secondButtonText: "secondButtonText", showSecondButton: false);
      } else if (signUp.status == SignUpStatus.Failed) {
        showErrorDialog(context,
            message: Provider.of<ErrorString>(context, listen: false)
                .getErrorString());
      }
    }).onError((error, stackTrace) {
      isLoading = false;
      setState(() {});
      showErrorDialog(context, message: "An undefined error occurred.".tr());
    });
  }

  _getCityDropDown() {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.kAuthColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: DropdownButton(
          dropdownColor: Colors.white,
          padding: EdgeInsets.zero,
          isExpanded: true,
          underline: const SizedBox(),
          icon: Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10),
            child: Icon(
              Icons.arrow_drop_down,
              color: AppColors.primary,
            ),
          ),
          hint: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Text(
                    "Select City".tr(),
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.contentDisabled,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
          value: _selectedCity,
          iconEnabledColor: AppColors.primary,
          iconDisabledColor: AppColors.primary,
          style: TextStyle(
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500),
          onChanged: (newValue) async {
            setState(() {
              _selectedCity = newValue;
            });
          },
          items: cityList.map((valueItem) {
            return DropdownMenuItem(
                value: valueItem,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    valueItem.name.toString().tr(),
                    style: TextStyle(
                      color: AppColors.contentDisabled,
                      fontSize: 14,
                    ),
                  ),
                ));
          }).toList(),
        ));
  }
}
