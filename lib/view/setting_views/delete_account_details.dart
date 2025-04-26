

import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


// ignore: must_be_immutable
class DeleteAccountViewDetails extends StatelessWidget {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(context, text: 'Delete Account'.tr(), showText: true),
        body: _getUI(context));
  }

  Widget _getUI(BuildContext context) {
    var status = Provider.of<AppState>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deleting your Account".tr(),
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(
            height: 30,
          ),
          // Text(
          //     "We'd hate to see you go, but if you are decided then here are few things you need to know.\n\nOnce your account is deleted, you can't reactive it, recover your data, or regain access. You'll need to set up a new account if you want to use Okab Rider again.".tr()),
          Text(
              "We'd hate to see you go, but if you are decided then here are few things you need to know.".tr()),
          SizedBox(
            height: 30,
          ),
          Text(
              "Once your account is deleted, you can't reactive it, recover your data, or regain access. You'll need to set up a new account if you want to use Okab Rider again.".tr()),
          SizedBox(
            height: 40,
          ),
          AppButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeleteAccountView()));
              },
              btnLabel: 'Continue'.tr())
        ],
      ),
    );
  }

  _forgotPassword(BuildContext context) async {
    var status = Provider.of<AppState>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = Provider.of<UserProvider>(context, listen: false);
    await AuthServices.instance()
        .deleteAccount(context,
            email: user.getUserDetails() == null
                ? user.getRiderDetails()!.email.toString()
                : user.getUserDetails()!.email.toString(),
            password: _controller.text)
        .then((val) async {
      prefs.clear();
      if (status.getStateStatus() == StateStatus.IsFree) {
        showNavigationDialog(context,
            message: "Account has been deleted successfully.".tr(),
            buttonText: "Okay".tr(), navigation: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SelectModeView()),
              (route) => false);
        }, secondButtonText: "", showSecondButton: false);
      } else if (status.getStateStatus() == StateStatus.IsError) {
        showErrorDialog(context,
            message: Provider.of<ErrorString>(context, listen: false)
                .getErrorString());
      }
    });
  }
}
