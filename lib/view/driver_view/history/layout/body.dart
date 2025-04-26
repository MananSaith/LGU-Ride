import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../configuration/frontend_configs.dart';
import '../campleted/completed_view.dart';
import '../canceled/canceled_view.dart';

class HistoryBody extends StatelessWidget {
  const HistoryBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            TabBar(

                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                labelStyle: TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(
                    color: AppColors.contentDisabled,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                indicatorWeight: 1,
                tabs: [
                  Tab(
                    text: "Completed".tr(),
                  ),
                  Tab(
                    text: "Canceled".tr(),
                  ),
                ]),
            const SizedBox(
              height: 18,
            ),
            const Expanded(
              child: TabBarView(
                  children: [CompletedView(), CanceledView()]),
            ),
          ],
        ),
      ),
    );
  }
}
