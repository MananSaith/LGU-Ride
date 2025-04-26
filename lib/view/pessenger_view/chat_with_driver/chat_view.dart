import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';

import 'layout/body.dart';

class ChatView extends StatefulWidget {
  final RideModel model;
  final bool isRider;

  const ChatView({super.key, required this.model, this.isRider = false});

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          children: [
            Text(
              widget.isRider
                  ? widget.model.userName.toString()
                  : widget.model.riderName.toString(),
              style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              "Online".tr(),
              style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                callHelper(widget.model.riderPhoneNumber.toString());
              },
              icon: Icon(
                Icons.call,
                color: AppColors.primary,
              )),
        ],
      ),
      body: ChatViewBody(
        model: widget.model,
        isRider: widget.isRider,
      ),
    );
  }
}
