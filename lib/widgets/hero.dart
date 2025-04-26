import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


class HeroWidgetView extends StatelessWidget {
  final String image;

  const HeroWidgetView({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: PhotoView(
            imageProvider: NetworkImage(image),
            minScale: PhotoViewComputedScale.contained,
          ),
        ));
  }
}