import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class UpdateDriverProfileViewBody extends StatefulWidget {
  UpdateDriverProfileViewBody({Key? key}) : super(key: key);

  @override
  State<UpdateDriverProfileViewBody> createState() =>
      _UpdateDriverProfileViewBodyState();
}

class _UpdateDriverProfileViewBodyState
    extends State<UpdateDriverProfileViewBody> {
  final TextEditingController _emailController = TextEditingController();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  File? file;
  bool isLoading = false;

  @override
  void initState() {
    var user = Provider.of<UserProvider>(context, listen: false);
    _nameController =
        TextEditingController(text: user.getRiderDetails()!.name.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    var code = context.locale.languageCode;
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
                //   "Update your \nProfile".tr(),
                //   style: AppColors.kHeadingStyle,
                // ),
                code != "en"
                    ? Text(
                  "Update your Profile".tr(),
                  style: AppColors.kHeadingStyle,
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Update your",
                      style: AppColors.kHeadingStyle,
                    ),
                    Text(
                      "Profile",
                      style: AppColors.kHeadingStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                if (file != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          getImage();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              file!,
                              height: 100,
                              fit: BoxFit.cover,
                              width: 100,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            getImage();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl:
                                  user.getRiderDetails()!.image.toString(),
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      Image.asset(
                                'assets/images/ph.jpg',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/ph.jpg',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 18,
                ),
                CustomTextField(
                    isSecure: false,
                    controller: _nameController,
                    icon: "assets/svg/person_icon.svg",
                    text: 'Full Name'.tr(),
                    onTap: () {},
                    keyBoardType: TextInputType.text),
                const SizedBox(
                  height: 24,
                ),
                AppButton(
                    onPressed: () async {
                      if (_nameController.text.isEmpty) {
                        getFlushBar(context, title: 'Name cannot be empty.'.tr());
                        return;
                      }
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      try {
                        isLoading = true;
                        setState(() {});
                        await UploadFileServices()
                            .getUrl(context, file)
                            .then((value) async {
                          await RiderServices()
                              .updateUserData(
                                  model: RiderModel(
                            name: _nameController.text,
                            image: value == ""
                                ? user.getRiderDetails()!.image.toString()
                                : value,
                            docId: user.getRiderDetails()!.docId.toString(),
                          ))
                              .then((value) async {
                            await RiderServices()
                                .fetchUpdateRiderData(
                                    user.getRiderDetails()!.docId.toString())
                                .then((value) {
                              user.saveRiderData(value);
                              prefs.setString(
                                  "USER_DATA", riderModelToJson(value));
                              prefs.setString("TYPE", "RIDER");
                              showNavigationDialog(context,
                                  message:
                                      "Profile has been updated successfully.".tr(),
                                  buttonText: "Okay".tr(), navigation: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                                  secondButtonText: "secondButtonText",
                                  showSecondButton: false);
                            });
                          });
                        });
                      } catch (e) {
                        getFlushBar(context, title: e.toString());
                      } finally {
                        isLoading = false;
                        setState(() {});
                      }
                    },
                    btnLabel: "Update Profile".tr()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    XFile? res = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (res != null) {
        file = File(res.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
