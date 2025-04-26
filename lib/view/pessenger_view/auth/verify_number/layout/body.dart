
import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class VerifyNumberBody extends StatefulWidget {
  const VerifyNumberBody({Key? key}) : super(key: key);

  @override
  State<VerifyNumberBody> createState() => _VerifyNumberBodyState();
}

class _VerifyNumberBodyState extends State<VerifyNumberBody> {
  Country? _selectedCountry;
  final TextEditingController _countryController = TextEditingController();

  @override
  void initState() {
    initCountry();
    super.initState();
  }

  void initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      _selectedCountry = country;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Phone \nVerification".tr(),
                style: AppColors.kHeadingStyle,
              ),
              const SizedBox(
                height: 34,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/otp.png",height:200,),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                height: 49,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _countryController,
                  decoration: InputDecoration(
                    hintText: "Phone Number".tr(),
                    hintStyle: TextStyle(
                        color: AppColors.contentDisabled,
                        fontSize: 14,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color:AppColors.contentDisabled)),
                    fillColor: AppColors.kAuthColor,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_selectedCountry != null)
                            Image.asset(
                              _selectedCountry!.flag.toString(),
                              package: countryCodePackageName,
                              height: 30,
                              width: 30,
                            ),
                          const SizedBox(
                            width: 6,
                          ),
                          InkWell(
                              onTap: () {
                                _onPressedShowDialog();
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down_sharp,
                                size: 20,
                                color: AppColors.contentDisabled,
                              )),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 1,
                            color: AppColors.contentDisabled.withOpacity(0.5),
                          ),
                          const SizedBox(
                            width: 6,
                          )
                        ],
                      ),
                    ),
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 34,
              ),
              AppButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const OTPView()));
                  },
                  btnLabel: "Verify Number".tr())
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedShowDialog() async {
    final country = await showCountryPickerDialog(
      context,
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }
}
