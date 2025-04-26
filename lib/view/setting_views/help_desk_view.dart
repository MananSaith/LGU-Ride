

import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';
class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, text: 'Help Desk'.tr(), showText: true),
      body: LoadingOverlay(
        isLoading: isLoading,
        progressIndicator: ProcessingWidget(),
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  text: 'Name'.tr(),
                  controller: nameController,
                  icon: '',
                  onTap: () {},
                  isSecure: false,
                  keyBoardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  text: 'Contact Number'.tr(),
                  controller: phoneController,
                  icon: '',
                  onTap: () {},
                  isSecure: false,
                  keyBoardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  text: 'Subject'.tr(),
                  controller: subjectController,
                  icon: '',
                  onTap: () {},
                  isSecure: false,
                  keyBoardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  text: 'Query'.tr(),
                  controller: descriptionController,
                  icon: '',
                  isSecure: false,
                  onTap: () {},
                  keyBoardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 25,
                ),
                AppButton(
                  btnLabel: "Submit".tr(),
                  onPressed: () async {
                    if (nameController.text.isEmpty) {
                      getFlushBar(context, title: "Name cannot be empty.".tr());
                      return;
                    }
                    if (phoneController.text.isEmpty) {
                      getFlushBar(context,
                          title: "Phone Number cannot be empty.".tr());
                      return;
                    }
                    if (subjectController.text.isEmpty) {
                      getFlushBar(context, title: "Subject cannot be empty.".tr());
                      return;
                    }
                    if (descriptionController.text.isEmpty) {
                      getFlushBar(context, title: "Description cannot be empty.".tr());
                      return;
                    }
                    try {
                      isLoading = true;
                      setState(() {});
                      await ContactUsServices()
                          .addQuery(ContactUsModel(
                              name: nameController.text,
                              email: emailController.text,
                              phoneNumber: phoneController.text,
                              subject: subjectController.text,
                              description: descriptionController.text))
                          .then((value) {
                        showNavigationDialog(context,
                            message:
                                "Your query has been submitted successfully.".tr(),
                            buttonText: "Okay".tr(), navigation: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          // Navigator.pop(context);
                        },
                            secondButtonText: "secondButtonText",
                            showSecondButton: false);
                      });
                    } catch (e) {
                      getFlushBar(context, title: e.toString());
                    }finally{
                      isLoading = false;
                      setState(() {});
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
