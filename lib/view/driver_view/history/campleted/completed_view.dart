import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class CompletedView extends StatelessWidget {
  const CompletedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return StreamProvider.value(
        value: RideServices()
            .streamRiderCompletedRides(user.getRiderDetails()!.docId.toString()),
        initialData: [RideModel()],
        builder: (context, child) {
          List<RideModel> rideList = context.watch<List<RideModel>>();
          return rideList.isNotEmpty
              ? rideList[0].docId == null
                  ? Center(
                      child: ProcessingWidget(),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: rideList.length,
                              shrinkWrap: true,
                              // physics:const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                return HistoryCard(
                                  model: rideList[i],
                                );
                              }),
                        ),
                      ],
                    )
              : SizedBox();
        });
  }
}
