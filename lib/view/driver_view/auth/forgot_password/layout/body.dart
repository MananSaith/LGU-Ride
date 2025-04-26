import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class ForgotPasswordViewBody extends StatelessWidget {
  ForgotPasswordViewBody({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();

  LoginBusinessLogic data = LoginBusinessLogic();

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
                Text(
                  "Reset Password".tr(),
                  style: AppColors.kHeadingStyle,
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
                AppButton(
                    onPressed: () {
                      if (_emailController.text.isEmpty) {
                        getFlushBar(context, title: "Email cannot be empty.".tr());
                        return;
                      }

                      _forgotPassword(context);
                    },
                    btnLabel: "Get Reset Link".tr()),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _forgotPassword(BuildContext context) async {
    AuthServices _services = Provider.of<AuthServices>(context, listen: false);
    await _services
        .forgotPassword(context, email: _emailController.text)
        .then((val) async {
      if (_services.status == Status.Authenticated) {
        showNavigationDialog(context,
            message:
                "An email with password reset link has been sent to your provided email.".tr(),
            buttonText: "Okay".tr(), navigation: () {
          Navigator.pop(context);
          Navigator.pop(context);
        }, secondButtonText: "", showSecondButton: false);
      } else {
        showErrorDialog(context,
            message: Provider.of<ErrorString>(context, listen: false)
                .getErrorString());
      }
    });
  }
}
