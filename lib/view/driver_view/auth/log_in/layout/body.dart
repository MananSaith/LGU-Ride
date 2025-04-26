import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class DriverLogInBody extends StatelessWidget {
  DriverLogInBody({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                                    DriverForgotPasswordView()));
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
        .loginDriverLogic(context, email: email, password: password)
        .then((val) async {
      if (auth.status == Status.Authenticated) {
        if (val.vehicleTypeID == null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CarRegistrationView()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DriverHomeView()));
        }
      } else {
        showErrorDialog(context,
            message: Provider.of<ErrorString>(context, listen: false)
                .getErrorString().tr());
      }
    });
  }
}
