
import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class TermsAndCondition extends StatefulWidget {
  @override
  TermsAndConditionState createState() => TermsAndConditionState();
}

class TermsAndConditionState extends State<TermsAndCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          customAppBar(context,text: "Terms & Conditions".tr(),showText: true),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamProvider.value(
              value:
                  TermsAndConditionServices().streamTermsAndConditions(context),
              initialData: [PrivacyPolicyModel()],
              builder: (context, child) {
                List<PrivacyPolicyModel> model =
                    context.watch<List<PrivacyPolicyModel>>();
                log(model[0].file.toString());
                return model.isNotEmpty
                    ? model[0].file == null
                        ? const Center(
                            child: ProcessingWidget(),
                          )
                        : SfPdfViewer.network(model[0].file.toString(),pageSpacing: 0,)
                    : const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
