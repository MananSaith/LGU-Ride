import 'package:flutter/material.dart';
import 'drawer_view.dart';
import 'layout/body.dart';

class DriverHomeView extends StatelessWidget {
  DriverHomeView({Key? key}) : super(key: key);


  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: DriverHomeBody(scaffoldKey: scaffoldKey,),
      drawer: const DrawerView(),
    );
  }
}
