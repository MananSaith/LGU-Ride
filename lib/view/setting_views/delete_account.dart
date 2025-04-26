import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class DeleteAccountView extends StatelessWidget {
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
    return LoadingOverlay(
      isLoading: status.getStateStatus() == StateStatus.IsBusy,
      progressIndicator: ProcessingWidget(),
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              CustomTextField(
                controller: _controller,
                icon: "assets/svg/lock_icon.svg",
                text: 'Password'.tr(),
                onTap: () {},
                keyBoardType: TextInputType.text,
                isPassword: true,
              ),
              SizedBox(
                height: 30,
              ),
              AppButton(
                  onPressed: () {
                    if (_controller.text.isEmpty) {
                      getFlushBar(context, title: "Password cannot be empty.".tr());
                      return;
                    }

                    _forgotPassword(context);
                  },
                  btnLabel: 'Delete Account'.tr()),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
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
