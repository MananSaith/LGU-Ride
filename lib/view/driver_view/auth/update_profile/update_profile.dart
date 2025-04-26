import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

import 'layout/body.dart';

class UpdateDriverProfileView extends StatelessWidget {
  const UpdateDriverProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
      ),
      body: UpdateDriverProfileViewBody(),
    );
  }
}
