import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class ChatViewBody extends StatefulWidget {
  final RideModel model;
  final bool isRider;

  const ChatViewBody({Key? key, required this.model, this.isRider = false})
      : super(key: key);

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

TextEditingController _controller = TextEditingController();
final List<Message> messages = [
  Message(0,
      "But I may not go if the weather is bad. So lets see the weather condition 😀".tr()),
  Message(1, "I suppose I am.".tr()),
  Message(2,
      "But I may not go if the weather is bad. So lets see the weather condition 😀".tr()),
  Message(3, "I suppose I am.".tr()),
];

class _ChatViewBodyState extends State<ChatViewBody> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return StreamProvider.value(
        value: ChatServices()
            .streamGroupMessage(groupID: widget.model.docId.toString()),
        initialData: [GroupMessageModel()],
        builder: (context, child) {
          List<GroupMessageModel> groupMessageList =
              context.watch<List<GroupMessageModel>>();
          return Column(
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: groupMessageList.isNotEmpty
                    ? groupMessageList[0].senderId == null
                        ? Center(
                            child: ProcessingWidget(),
                          )
                        : ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 10.0);
                            },
                            itemCount: groupMessageList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return MessageRowWidget(
                                current: widget.isRider
                                    ? groupMessageList[index].senderId ==
                                        user.getRiderDetails()!.docId.toString()
                                    : groupMessageList[index].senderId ==
                                        user.getUserDetails()!.docId.toString(),
                                message: groupMessageList[index],
                              );
                            },
                          )
                    : SizedBox(),
              ),
              _bottomBarWidget()
            ],
          );
        });
  }

  Widget _bottomBarWidget() {
    var user = Provider.of<UserProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 2.0,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 20.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.contentDisabled)),
              child: TextField(
                textInputAction: TextInputAction.send,
                controller: _controller,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Write your message here....".tr(),
                    hintStyle: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          CircleAvatar(
            backgroundColor: AppColors.primary,
            radius: 18,
            child: IconButton(
              icon: SvgPicture.asset('assets/svg/send_icon.svg'),
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                if (_controller.text.isEmpty) {
                  getFlushBar(context, title: "Message cannot be empty.".tr());
                  return;
                }
                try {
                  await ChatServices().sendMessage(context,
                      model: GroupMessageModel(
                        message: _controller.text,
                        senderId: widget.isRider
                            ? user.getRiderDetails()!.docId.toString()
                            : user.getUserDetails()!.docId.toString(),
                        senderName: widget.isRider
                            ? user.getRiderDetails()!.name.toString()
                            : user.getUserDetails()!.name.toString(),
                        fileUrl: "",
                        fileName: "",
                        userImage: widget.isRider
                            ? user.getRiderDetails()!.image.toString()
                            : user.getUserDetails()!.image.toString(),
                      ),
                      groupID: widget.model.docId.toString());
                  await NotificationHandler().oneToOneNotificationHelper(
                      docID: widget.isRider
                          ? user.getRiderDetails()!.docId.toString()
                          : user.getUserDetails()!.docId.toString(),
                      body: "You have new message to see.".tr(),
                      title: "Message Update!".tr());
                  _controller.clear();
                } catch (e) {
                  getFlushBar(context, title: e.toString());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
