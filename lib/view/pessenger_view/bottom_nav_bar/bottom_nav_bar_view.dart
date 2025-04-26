import 'package:easy_localization/easy_localization.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riding_app/models/ride.dart';
import 'package:riding_app/view/pessenger_view/driver_arriving/driver_arriving_view.dart';
import 'package:riding_app/view/pessenger_view/passengar_history/history_view.dart';
import 'package:riding_app/view/pessenger_view/ride_start/ride_start_view.dart';
import 'package:riding_app/view/pessenger_view/searching_driver/searching_driver_view.dart';
import '../../../configuration/frontend_configs.dart';
import '../chat_details/chat_view.dart';
import '../home/home_view.dart';
import '../profile/profile_view.dart';
import '../wallet/wallet_view.dart';

class BottomNavBarView extends StatefulWidget {
  final String? status;
  final RideModel? model;

  const BottomNavBarView({Key? key, this.status, this.model}) : super(key: key);

  @override
  _BottomNavBarViewState createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  int _currentIndex = 0;

  // void onTabTapped(int index, BuildContext context) {
  //   // var bottomIndex = Provider.of<BottomIndexProvider>(context, listen: false);
  //   bottomIndex.setIndex(index);
  // }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget getHomeWidget() {
    if (widget.status == "EMPTY") {
      return HomeView();
    } else if (widget.status == "SEARCHING") {
      return SearchingDriverView(
          rideID: widget.model!.docId.toString(),
          vehicleID: widget.model!.vehicleType.toString(),
          vehicleImage: widget.model!.vehicleIcon.toString());
    } else if (widget.status == "ARRIVING") {
      return DriverArrivingView(rideID: widget.model!.docId.toString());
    } else if (widget.status == "START") {
      return RideStartView(rideID: widget.model!.docId.toString());
    } else {
      return HomeView();
    }
  }

  @override
  Widget build(BuildContext context) {
    log(widget.status.toString());
    final List<Widget> _children = [
      getHomeWidget(),
      const PassengerHistoryView(),
      const ProfileView()
    ];
    // var bottomIndex = Provider.of<BottomIndexProvider>(context);
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.contentDisabled,
        backgroundColor: Colors.white,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 10,
          fontFamily: "Poppins",
          color: AppColors.primary,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 10,
          fontFamily: "Poppins",
          color: AppColors.contentDisabled,
        ),
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        // currentIndex:getIndex,
        items: [
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: SvgPicture.asset(
                  height: 18,
                  width: 18,
                  'assets/svg/home_icon.svg',
                  color: _currentIndex == 0
                      ? AppColors.primary
                      : AppColors.contentDisabled,
                ),
              ),
              label: "Home".tr()),
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: SvgPicture.asset(
                  height: 16,
                  width: 16,
                  'assets/svg/wallet_icon.svg',
                  color: _currentIndex == 1
                      ? AppColors.primary
                      : AppColors.contentDisabled,
                ),
              ),
              label: "History".tr()),
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: SvgPicture.asset(
                  'assets/svg/person_icon.svg',
                  color: _currentIndex == 2
                      ? AppColors.primary
                      : AppColors.contentDisabled,
                  height: 18,
                  width: 18,
                ),
              ),
              label: "Profile".tr()),
        ],
      ),
    );
  }
}
