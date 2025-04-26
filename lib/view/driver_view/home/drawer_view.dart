import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return SizedBox(
      width: 240,
      child: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: context.locale.languageCode == "ur" ? 275 : 250,
              child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: user.getRiderDetails()!.image.toString(),
                          height: 62,
                          width: 62,
                          memCacheHeight: 500,
                          memCacheWidth: 500,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Image.asset(
                            'assets/images/ph.jpg',
                            height: 62,
                            width: 62,
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/ph.jpg',
                            height: 62,
                            width: 62,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomText(
                        text: user.getRiderDetails()!.name.toString(),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomText(
                        text: user.getRiderDetails()!.phoneNumber.toString(),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomText(
                        text: "CNIC: ".tr() +
                            user.getRiderDetails()!.cnic.toString(),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomText(
                        text: "City: ".tr() +
                            user.getRiderDetails()!.cityName.toString(),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/home_icon.svg",
                  height: 20,
                  width: 20,
                ),
                title: CustomText(
                  text: 'Home'.tr(),
                  color: AppColors.contentDisabled,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/person_icon.svg",
                  height: 18,
                  width: 18,
                ),
                title: CustomText(
                  text: 'Update Profile'.tr(),
                  color: AppColors.contentDisabled,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const UpdateDriverProfileView()));
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/car_icon.svg",
                  height: 18,
                  color: Color(0xff9B9B9B),
                  width: 18,
                ),
                title: CustomText(
                  text: 'Vehicle Details'.tr(),
                  color: AppColors.contentDisabled,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VehicleDetailsView()));
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/trip_history.svg",
                  color: AppColors.contentDisabled,
                  height: 20,
                  width: 20,
                ),
                title: CustomText(
                  text: 'Trip History'.tr(),
                  color: AppColors.contentDisabled,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoryView()));
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/language.svg",
                  color: AppColors.contentDisabled,
                  height: 20,
                  width: 20,
                ),
                title: CustomText(
                  text: 'Language'.tr(),
                  color: AppColors.contentDisabled,
                ),
                onTap: () {
                  // Navigator.pop(context);
                  showChangeLanguageDialog(context);
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/privacy.svg",
                  color: AppColors.contentDisabled,
                  height: 20,
                  width: 20,
                ),
                title: CustomText(
                  text: 'Help Desk'.tr(),
                  color: AppColors.contentDisabled,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ContactUsView()));
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/privacy.svg",
                  color: AppColors.contentDisabled,
                  height: 20,
                  width: 20,
                ),
                title: CustomText(
                  text: 'Privacy Policy'.tr(),
                  color: AppColors.contentDisabled,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyPolicyView()));
                },
              ),
            ),
            // SizedBox(
            //   height: 40,
            //   child: ListTile(
            //     minLeadingWidth: 2,
            //     leading: SvgPicture.asset(
            //       "assets/svg/privacy.svg",
            //       color: AppColors.contentDisabled,
            //       height: 20,
            //       width: 20,
            //     ),
            //     title: CustomText(
            //       text: 'Terms and Conditions'.tr(),
            //       color: AppColors.contentDisabled,
            //     ),
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => TermsAndCondition()));
            //     },
            //   ),
            // ),
            SizedBox(
              height: 40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/help_center.svg",
                  color: AppColors.contentDisabled,
                  height: 20,
                  width: 20,
                ),
                title: CustomText(
                  text: 'Help Center'.tr(),
                  color: AppColors.contentDisabled,
                ),
                onTap: () {
                 // _launchUrl('mailto:mrmanan143@gmail.com');
                  String phoneNumber = "923027465514"; // Replace with your number
                  String message = Uri.encodeComponent("Hello! I need some help LGU Ride App.");
                  _launchUrl("https://wa.me/$phoneNumber?text=$message");
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/help_center.svg",
                  color: AppColors.contentDisabled,
                  height: 20,
                  width: 20,
                ),
                title: CustomText(
                  text: 'Delete Account'.tr(),
                  color: AppColors.contentDisabled,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DeleteAccountViewDetails()));
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/exit.svg",
                  color: Colors.red,
                  height: 20,
                  width: 20,
                ),
                title: CustomText(
                  text: 'Log out'.tr(),
                  color: Colors.red,
                ),
                onTap: () {
                  SharedPreferences.getInstance().then((value) {
                    value.clear();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LogInViewDriver(
                                  showBackButton: false,
                                )),
                        (route) => false);
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _launchUrl(String mail) async {
    if (!await launchUrl(Uri.parse(mail))) throw 'Could not launch $mail';
  }
}
