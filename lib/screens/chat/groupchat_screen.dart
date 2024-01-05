import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/authController.dart';
import 'package:whatsapp_clone/controllers/homeController.dart';
import 'package:whatsapp_clone/models/groupMessageModel.dart';
import 'package:whatsapp_clone/models/groupModel.dart';
import 'package:whatsapp_clone/screens/chat/chat_widgets.dart';
import 'package:whatsapp_clone/utils/colors.dart';

class GroupChatScreen extends StatelessWidget {
  final Group mygroup;
  const GroupChatScreen({super.key, required this.mygroup});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final ac = Get.find<AuthController>();
    TextEditingController messageController = TextEditingController();
    return Obx(
      () => homeController.obxvalue == true
          ? Scaffold()
          : WillPopScope(
              onWillPop: () {
                if (homeController.showEmoji.value) {
                  homeController.showEmoji.value =
                      !homeController.showEmoji.value;
                  return Future.value(false);
                } else {
                  return Future.value(true);
                }
              },
              child: Scaffold(
                appBar: AppBar(
                  titleSpacing: -20,
                  backgroundColor: tealDarkGreenColor,
                  leading: InkWell(
                      onTap: () {
                        if (homeController.showEmoji.value) {
                          homeController.showEmoji.value =
                              !homeController.showEmoji.value;
                        }
                        messageController.text = '';
                        Navigator.pop(context);
                      },
                      child: Icon(Platform.isIOS
                          ? Icons.arrow_back_ios
                          : Icons.arrow_back)),
                  iconTheme: IconThemeData(color: Colors.white),
                  title: StreamBuilder(
                      stream: homeController.getSpecificGroup(mygroup),
                      builder: (context, snapshot) {
                        var data = snapshot.data?.docs;

                        final list = data
                                ?.map((e) => Group.fromJson(e.data()))
                                .toList() ??
                            [];

                        return Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  image: DecorationImage(
                                      image: NetworkImage(list.isNotEmpty
                                          ? list[0].groupImage
                                          : mygroup.groupImage),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mygroup.groupId == ac.loginuser.value?.id
                                      ? 'Me (You)'
                                      : list.isNotEmpty
                                          ? list[0].groupName
                                          : mygroup.groupName,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Container(
                                    height: 20,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "You, ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: mygroup.members.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Text(
                                                  mygroup.members[index].id ==
                                                          ac.loginuser.value?.id
                                                      ? ''
                                                      : index ==
                                                              mygroup.members
                                                                      .length -
                                                                  1
                                                          ? '${mygroup.members[index].name}'
                                                          : '${mygroup.members[index].name}, ',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                );
                                              }),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        );
                      }),
                  centerTitle: false,
                  actions: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.more_vert_outlined))
                  ],
                ),
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/bg.jpg"),
                          fit: BoxFit.cover)),
                  child: Column(
                    children: [
                      Expanded(
                          child: StreamBuilder(
                              stream: homeController.getGroupMessages(mygroup),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                  case ConnectionState.none:
                                    return const SizedBox();
                                  case ConnectionState.active:
                                  case ConnectionState.done:
                                    List<GroupMessage> msglist = [];
                                    var data = snapshot.data?.docs;

                                    msglist = data
                                            ?.map((e) =>
                                                GroupMessage.fromJson(e.data()))
                                            .toList() ??
                                        [];

                                    if (msglist.isNotEmpty) {
                                      return ListView.builder(
                                          reverse: true,
                                          itemCount: msglist.length,
                                          itemBuilder: (context, index) {
                                            final reversedIndex =
                                                msglist.length - 1 - index;
                                            return msglist[reversedIndex]
                                                        .fromId ==
                                                    ac.loginuser.value?.id
                                                ? groupchatcard(
                                                    msglist[reversedIndex],
                                                    context)
                                                : oppGroupchatCard(
                                                    msglist[reversedIndex],
                                                    context);
                                          });
                                    } else {
                                      return Center(
                                        child: Text("Let's Chat"),
                                      );
                                    }
                                }
                              })),
                      chatInput(messageController, context, 'groupchat',
                          group: mygroup),

                      //emoji picker
                      if (homeController.showEmoji.value)
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.34,
                          child: EmojiPicker(
                            onEmojiSelected: (category, emoji) {
                              homeController.chatText.value =
                                  messageController.text;
                            },
                            textEditingController: messageController,
                            config: Config(
                              columns: 8,
                              emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
