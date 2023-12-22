import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/homeController.dart';
import 'package:whatsapp_clone/models/chatuserModel.dart';
import 'package:whatsapp_clone/models/messageModel.dart';
import 'package:whatsapp_clone/screens/chat/chat_widgets.dart';
import 'package:whatsapp_clone/utils/colors.dart';

class ChatScreen extends StatelessWidget {
  final Chatuser mychatuser;

  const ChatScreen({super.key, required this.mychatuser});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    TextEditingController messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -20,
        backgroundColor: tealDarkGreenColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  image: DecorationImage(
                      image: NetworkImage(mychatuser.image),
                      fit: BoxFit.cover)),
            ),
            SizedBox(width: 10),
            Text(
              mychatuser.name,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                    stream: homeController.getAllMessages(mychatuser),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return const SizedBox();
                        case ConnectionState.active:
                        case ConnectionState.done:
                          List<Message> msglist = [];
                          var data = snapshot.data?.docs;

                          msglist = data
                                  ?.map((e) => Message.fromJson(e.data()))
                                  .toList() ??
                              [];

                          if (msglist.isNotEmpty) {
                            return ListView.builder(
                                itemCount: msglist.length,
                                itemBuilder: (context, index) {
                                  return chatcard(msglist[index], context);
                                });
                          } else {
                            return Center(
                              child: Text("Let's Chat"),
                            );
                          }
                      }
                    })),
            chatInput(messageController, mychatuser)
          ],
        ),
      ),
    );
  }
}
