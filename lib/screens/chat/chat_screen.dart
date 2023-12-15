import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/chat/chat_card.dart';
import 'package:whatsapp_clone/utils/colors.dart';
import 'package:whatsapp_clone/utils/info.dart';

class ChatScreen extends StatelessWidget {
  final String contactname;
  final String profilepic;
  const ChatScreen(
      {super.key, required this.contactname, required this.profilepic});

  @override
  Widget build(BuildContext context) {
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
                      image: NetworkImage(profilepic), fit: BoxFit.cover)),
            ),
            SizedBox(width: 10),
            Text(
              contactname,
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
                child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return messages[index]['isMe'] == true
                          ? chatcard(
                              message: messages[index]['text'].toString(),
                              time: messages[index]['time'].toString(),
                              ismychat: true)
                          : chatcard(
                              message: messages[index]['text'].toString(),
                              time: messages[index]['time'].toString(),
                              ismychat: false);
                    }))
          ],
        ),
      ),
    );
  }
}
