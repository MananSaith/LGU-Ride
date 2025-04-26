
import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

class PrivacyPolicyView extends StatefulWidget {
  @override
  PrivacyPolicyViewState createState() => PrivacyPolicyViewState();
}

class PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          customAppBar(context,text: "Privacy Policy".tr(),showText: true),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamProvider.value(
              value: PrivacyPolicyServices().streamPrivacyPolicy(context),
              initialData: [PrivacyPolicyModel()],
              builder: (context, child) {
                List<PrivacyPolicyModel> model =
                    context.watch<List<PrivacyPolicyModel>>();
                return model.isNotEmpty
                    ? model[0].file == null
                        ? const Center(
                            child: ProcessingWidget(),
                          )
                        : SfPdfViewer.network(model[0].file.toString(),pageSpacing: 0,)
                    : SizedBox(
                        child: Text("No Data".tr()),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
