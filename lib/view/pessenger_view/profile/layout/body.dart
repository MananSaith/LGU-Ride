import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class ProfileBody extends StatefulWidget {
  ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final Color redColor = const Color(0xffFF455B);

  bool isFirstSelected = false;

  bool isSecondSelected = false;

  bool isThirdSelected = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    String languageCode = context.locale.languageCode;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: user.getUserDetails()!.image.toString(),
                      height: 80,
                      width: 80,
                      memCacheHeight: 500,
                      memCacheWidth: 500,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Image.asset(
                        'assets/images/ph.jpg',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/ph.jpg',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomText(
                    text: user.getUserDetails()!.name.toString(),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  CustomText(
                    text: user.getUserDetails()!.phoneNumber.toString(),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          SettingWidget(
            icon: "assets/svg/user.svg",
            title: "John_wick".tr(),
            name: 'Edit profile'.tr(),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UpdateProfileView()));
            },
          ),
          InkWell(
            onTap: () {
              showChangeLanguageDialog(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SettingWidget(
                  icon: "assets/svg/language.svg",
                  title: "",
                  name: 'Language'.tr(),
                  isShow: true,
                  onTap: () {
                    showChangeLanguageDialog(context);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Row(
                    children: [
                      Text(
                          languageCode == "en"
                              ? "English (US)".tr()
                              : languageCode == "ur"
                                  ? "Urdu".tr()
                                  // : languageCode == "ar"
                                  //     ? "Pashto".tr()
                                      : "",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      SizedBox(
                        width: 3,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                      languageCode != "en" ?
                      SizedBox(
                        width: 18,
                      ) : SizedBox()
                    ],
                  ),
                )
              ],
            ),
          ),
          SettingWidget(
            icon: "assets/svg/privacy.svg",
            title: "John_wick".tr(),
            name: 'Privacy Policy'.tr(),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicyView()));
            },
          ),
          SettingWidget(
            icon: "assets/svg/privacy.svg",
            title: "John_wick".tr(),
            name: 'Help Desk'.tr(),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactUsView()));
            },
          ),
          SettingWidget(
            icon: "assets/svg/privacy.svg",
            title: "John_wick".tr(),
            name: 'Terms & Conditions'.tr(),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TermsAndCondition()));
            },
          ),
          SettingWidget(
            icon: "assets/svg/help_center.svg",
            title: "",
            name: 'Help Center'.tr(),
              onTap: () {
                String phoneNumber = "923027465514"; // Replace with your number
                String message = Uri.encodeComponent("Hello! I need some help LGU Ride App.");
                _launchUrl("https://wa.me/$phoneNumber?text=$message");
              }

            // onTap: () {
            //   _launchUrl('mailto:sfaiz4210@gmail.com');
            // },
          ),
          // SettingWidget(
          //   icon: "assets/svg/rating_star.svg",
          //   title: "",
          //   name: 'Rate Our App'.tr(),
          //   onTap: () {
          //     LaunchReview.launch();
          //   },
          // ),
          SettingWidget(
            icon: "assets/svg/help_center.svg",
            title: "",
            name: 'Delete Account'.tr(),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DeleteAccountViewDetails()));
            },
          ),
          InkWell(
            onTap: () {
              showNavigationDialog(context,
                  message: "Do you really want to logout from app?".tr(),
                  buttonText: "Yes".tr(), navigation: () {
                SharedPreferences.getInstance().then((value) {
                  value.remove('TYPE');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PassengerLogInView(showBackButton: false,)),
                      (route) => false);
                });
              }, secondButtonText: "No".tr(), showSecondButton: true);
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/exit.svg",
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Text(
                    "Log out".tr(),
                    style: TextStyle(
                        color: redColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchUrl(String mail) async {
    if (!await launchUrl(Uri.parse(mail))) throw 'Could not launch $mail';
  }
}
