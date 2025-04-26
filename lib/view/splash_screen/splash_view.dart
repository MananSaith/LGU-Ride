import 'package:flutter/material.dart';
import 'layout/body.dart';


class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
       // backgroundColor:Colors.green.withOpacity(0.5),
      body:SplashBody(),
    );
  }
}
