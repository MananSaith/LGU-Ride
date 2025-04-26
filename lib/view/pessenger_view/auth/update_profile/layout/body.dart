import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class UpdateProfileViewBody extends StatefulWidget {
  UpdateProfileViewBody({Key? key}) : super(key: key);

  @override
  State<UpdateProfileViewBody> createState() => _UpdateProfileViewBodyState();
}

class _UpdateProfileViewBodyState extends State<UpdateProfileViewBody> {
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
        TextEditingController(text: user.getUserDetails()!.name.toString());
    _phoneNumberController = TextEditingController(
        text: user.getUserDetails()!.phoneNumber.toString());
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
                              imageUrl: user.getUserDetails()!.image.toString(),
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
                  height: 24,
                ),
                AppButton(
                    onPressed: () async {
                      if (_nameController.text.isEmpty) {
                        getFlushBar(context,
                            title: 'Name cannot be empty.'.tr());
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

                      try {
                        isLoading = true;
                        setState(() {});
                        await UploadFileServices()
                            .getUrl(context, file)
                            .then((value) async {
                          await UserServices()
                              .updateUserData(
                                  model: RiderModel(
                            name: _nameController.text,
                            image: value == ""
                                ? user.getUserDetails()!.image.toString()
                                : value,
                            phoneNumber: _phoneNumberController.text,
                            docId: user.getUserDetails()!.docId.toString(),
                          ))
                              .then((value) async {
                            await UserServices()
                                .fetchUpdatedData(
                                    user.getUserDetails()!.docId.toString())
                                .then((value) {
                              user.saveUserDetails(value);
                              showNavigationDialog(context,
                                  message:
                                      "Profile has been updated successfully."
                                          .tr(),
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
        .pickImage(source: ImageSource.gallery, imageQuality: 50,);
    setState(() {
      if (res != null) {
        file = File(res.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
