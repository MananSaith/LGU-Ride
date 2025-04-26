import 'package:easy_localization/easy_localization.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:riding_app/configuration/frontend_configs.dart';

import '../../../../pessenger_view/ride_start/layout/widgets/ride_selection_widget.dart';

class RideSelectionCard extends StatelessWidget {
  const RideSelectionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation:0.5,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            RideSelectionWidget(
              icon: 'assets/svg/pickup_icon.svg',
              title: 'Pick up Location'.tr(),
              body: '089 Stark Gateway'.tr(),
              onPressed: () {},
            ),
             Padding(
              padding: EdgeInsets.only(left: 20),
              child: DottedLine(
                direction: Axis.vertical,
                lineLength: 30,
                lineThickness: 1.0,
                dashLength: 4.0,
                dashColor: AppColors.primary,
                dashRadius: 2.0,
                dashGapLength: 4.0,
                dashGapRadius: 0.0,
              ),
            ),
            RideSelectionWidget(
              icon: 'assets/svg/location_icon.svg',
              title: 'Drop off Location'.tr(),
              body: '92676 Orion Meadows'.tr(),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
