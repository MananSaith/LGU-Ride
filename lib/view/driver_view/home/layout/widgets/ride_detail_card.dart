import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class RideDetailsCard extends StatefulWidget {
  final RideModel model;
  final BuildContext mainContext;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const RideDetailsCard(
      {super.key,
      required this.model,
      required this.mainContext,
      required this.onAccept,
      required this.onReject});

  @override
  State<RideDetailsCard> createState() => _RideDetailsCardState();
}

class _RideDetailsCardState extends State<RideDetailsCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 15),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Customer Details".tr(),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              Row(
                children: [
                  CustomText(
                    text: "Name: ".tr(),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    text: widget.model.userName.toString(),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              Row(
                children: [
                  CustomText(
                    text: "Phone Number: ".tr(),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    text: widget.model.userPhoneNumber.toString(),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              Divider(),
              CustomText(
                text: "Address Details".tr(),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "PickUp Location: ".tr(),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    text: widget.model.from.toString(),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Drop Off Location: ".tr(),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    text: widget.model.to.toString(),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              Divider(),
              const SizedBox(
                height: 8,
              ),
              CustomText(
                text: "Ride Details".tr(),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              Row(
                children: [
                  CustomText(
                    text: "Distance: ".tr(),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    text: widget.model.distance.toString() + " Km".tr(),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              Row(
                children: [
                  CustomText(
                    text: "Charges: ".tr(),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    text: "PKR: ".tr() + widget.model.amount.toString() + "/-",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Divider(
                color: AppColors.contentDisabled,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: widget.onReject,
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xff252525).withOpacity(0.15)),
                        child: Center(
                          child: CustomText(
                            text: 'Reject'.tr(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: widget.onAccept,
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.primary,
                        ),
                        child: Center(
                            child: CustomText(
                          text: 'Accept'.tr(),
                          color: Colors.white,
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
