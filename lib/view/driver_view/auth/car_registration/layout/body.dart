import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class CarRegistrationBody extends StatefulWidget {
  CarRegistrationBody({Key? key}) : super(key: key);

  @override
  State<CarRegistrationBody> createState() => _CarRegistrationBodyState();
}

class _CarRegistrationBodyState extends State<CarRegistrationBody> {
  final TextEditingController _carModelController = TextEditingController();

  final TextEditingController _carNumberController = TextEditingController();

  final TextEditingController _carYearController = TextEditingController();

  File? _vehicleDocs;

  File? _licenseImage;

  bool isLoading = false;

  List<VehicleModel> vehicleList = [];

  VehicleModel? _selectedVehicle;

  getVehicles() async {
    _selectedVehicle = null;
    vehicleList.clear();
    setState(() {});
    await VehicleServices().fetchVehicles().then((value) {
      vehicleList.addAll(value);
      setState(() {});
    });
  }

  @override
  void initState() {
    getVehicles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: ProcessingWidget(),
      color: Colors.transparent,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Add Vehicle \nDetails and Documents".tr(),
                //   style: AppColors.kHeadingStyle,
                // ),
                context.locale.languageCode == "en"
                    ? Column(
                        children: [
                          Text(
                            "Add Vehicle ".tr(),
                            style: AppColors.kHeadingStyle,
                          ),
                          Text(
                            "Details and Documents".tr(),
                            style: AppColors.kHeadingStyle,
                          ),
                        ],
                      )
                    : Text(
                        "Add Vehicle Details and Documents".tr(),
                        style: AppColors.kHeadingStyle,
                      ),
                const SizedBox(
                  height: 18,
                ),
                _getVehicleTypeDropDown(),
                const SizedBox(
                  height: 18,
                ),
                RegistrationFieldWidget(
                    controller: _carModelController,
                    keyBoardType: TextInputType.text,
                    text: 'Enter Vehicle Name'.tr()),
                const SizedBox(
                  height: 18,
                ),
                RegistrationFieldWidget(
                    controller: _carNumberController,
                    keyBoardType: TextInputType.text,
                    text: 'Enter Vehicle Number Plate'.tr()),
                const SizedBox(
                  height: 18,
                ),
                RegistrationFieldWidget(
                    controller: _carYearController,
                    keyBoardType: TextInputType.number,
                    text: 'Make Year'.tr()),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () {
                    getVehicleDocImage();
                  },
                  child: UploadFileWidget(
                      btnLebal: _vehicleDocs == null
                          ? 'Upload File'.tr()
                          : _vehicleDocs!.path
                              .split('/')
                              .last
                              .toString()
                              .replaceAll('scaled_', ''),
                      fileName: 'Upload vehicle Documents'.tr()),
                ),
                const SizedBox(
                  height: 18,
                ),
                InkWell(
                  onTap: () {
                    getLicenseImage();
                  },
                  child: UploadFileWidget(
                      btnLebal: _licenseImage == null
                          ? 'Upload File'.tr()
                          : _licenseImage!.path
                              .split('/')
                              .last
                              .toString()
                              .replaceAll('scaled_', ''),
                      fileName: 'Upload Photo of License'.tr()),
                ),
                SizedBox(
                  height: 50,
                ),
                AppButton(
                    onPressed: () async {
                      if (_selectedVehicle == null) {
                        getFlushBar(context,
                            title: "Kindly select vehicle type.".tr());
                        return;
                      }
                      if (_carModelController.text.isEmpty) {
                        getFlushBar(context,
                            title: "Vehicle name cannot be empty.".tr());
                        return;
                      }
                      if (_carNumberController.text.isEmpty) {
                        getFlushBar(context,
                            title:
                                "Vehicle plate number cannot be empty.".tr());
                        return;
                      }
                      if (_carYearController.text.isEmpty) {
                        getFlushBar(context,
                            title: "Vehicle make year cannot be empty.".tr());
                        return;
                      }
                      if (_vehicleDocs == null) {
                        getFlushBar(context,
                            title: "Kindly attach vehicle docs.".tr());
                        return;
                      }
                      // if (_licenseImage == null) {
                      //   getFlushBar(context,
                      //       title: "Kindly attach your driving license image.");
                      //   return;
                      // }

                      isLoading = true;
                      setState(() {});
                      try {
                        await UploadFileServices()
                            .getUrl(context, _vehicleDocs)
                            .then((vehicleDoc) async {
                          await UploadFileServices()
                              .getUrl(context, _licenseImage)
                              .then((licenseImage) async {
                            await RiderServices().addRiderVehicleDetails(
                                context,
                                model: RiderVehicleModel(
                                  vehicleName: _carModelController.text,
                                  vehiclePlateNumber: _carNumberController.text,
                                  vehicleDocuments: vehicleDoc,
                                  licenseCardImage: licenseImage,
                                  model: _carModelController.text,
                                ),
                                userID:
                                    user.getRiderDetails()!.docId.toString());
                            await RiderServices().updateVehicleType(
                              model: RiderModel(
                                  docId:
                                      user.getRiderDetails()!.docId.toString(),
                                  vehicleTypeID:
                                      _selectedVehicle!.docId.toString()),
                            );
                          }).then((value) {
                            showNavigationDialog(context,
                                message:
                                    "Thanks for providing your details. It might take 24 hours to verify your details. You will receive a link in your email inbox. Kindly activate your email first in order to continue."
                                        .tr(),
                                buttonText: "Okay".tr(), navigation: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogInViewDriver()));
                            },
                                secondButtonText: "secondButtonText",
                                showSecondButton: false);
                          });
                        });
                      } catch (e) {
                        getFlushBar(context, title: e.toString());
                        rethrow;
                      } finally {
                        isLoading = false;
                        setState(() {});
                      }
                    },
                    btnLabel: 'Continue'.tr()),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getVehicleDocImage() async {
    XFile? res = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (res != null) {
        _vehicleDocs = File(res.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getLicenseImage() async {
    XFile? res = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (res != null) {
        _licenseImage = File(res.path);
      } else {
        print('No image selected.');
      }
    });
  }
// init state ma hum na fun ko call kia hai jo Vehicle lai ga
  _getVehicleTypeDropDown() {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.kAuthColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: DropdownButton(
          dropdownColor: Colors.white,
          padding: EdgeInsets.zero,
          isExpanded: true,
          underline: const SizedBox(),
          icon: Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10),
            child: Icon(
              Icons.arrow_drop_down,
              color: AppColors.primary,
            ),
          ),
          hint: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Text(
                    "Select Vehicle Type".tr(),
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.contentDisabled,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
          value: _selectedVehicle,
          iconEnabledColor: AppColors.primary,
          iconDisabledColor: AppColors.primary,
          style: TextStyle(
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500),
          onChanged: (newValue) async {
            setState(() {
              _selectedVehicle = newValue;
            });
          },
          items: vehicleList.map((valueItem) {
            return DropdownMenuItem(
                value: valueItem,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    valueItem.vehicleName.toString().tr(),
                    style: TextStyle(
                      color: AppColors.contentDisabled,
                      fontSize: 14,
                    ),
                  ),
                ));
          }).toList(),
        ));
  }
}
