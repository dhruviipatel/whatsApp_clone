import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/homeController.dart';
import 'package:whatsapp_clone/models/chatuserModel.dart';
import 'package:whatsapp_clone/screens/chat/chat_screen.dart';
import 'package:whatsapp_clone/screens/profile/profile_widgets.dart';
import 'package:whatsapp_clone/utils/colors.dart';

class OppProfileScreen extends StatelessWidget {
  final Chatuser chatuser;
  const OppProfileScreen({super.key, required this.chatuser});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Obx(
      () => homeController.obxvalue == true
          ? Scaffold()
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                actions: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
                ],
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width / 3,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(chatuser.image),
                                fit: BoxFit.cover),
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width / 3)),
                      ),
                      Text(
                        chatuser.name,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        chatuser.phone,
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade700),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => Get.to(
                                  () => ChatScreen(mychatuser: chatuser)),
                              child: oppDataContainer(
                                  Icons.message, "Message", context),
                            ),
                            InkWell(
                              onTap: () => Get.to(
                                  () => ChatScreen(mychatuser: chatuser)),
                              child: oppDataContainer(
                                  Icons.call, "Audio", context),
                            ),
                            InkWell(
                              onTap: () => Get.to(
                                  () => ChatScreen(mychatuser: chatuser)),
                              child: oppDataContainer(
                                  Icons.video_call, "Video", context),
                            ),
                            InkWell(
                              onTap: () => Get.to(
                                  () => ChatScreen(mychatuser: chatuser)),
                              child: oppDataContainer(
                                  Icons.currency_rupee_rounded, "Pay", context),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 0.1,
                        child: Container(
                          height: 0.5,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Card(
                        shape: RoundedRectangleBorder(),
                        color: Colors.white,
                        elevation: 0.1,
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: 15, right: 20),
                          visualDensity: VisualDensity.compact,
                          title: Text(chatuser.about),
                          subtitle: Text(homeController.getJoiningDate(
                              context: context, date: chatuser.createdAt)),
                          titleTextStyle:
                              TextStyle(fontSize: 14, color: Colors.black),
                          subtitleTextStyle: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ),
                      SizedBox(height: 5),
                      sharedImagesList(chatuser),
                      SizedBox(height: 5),
                      Card(
                        shape: RoundedRectangleBorder(),
                        color: Colors.white,
                        elevation: 0.1,
                        child: Column(
                          children: [
                            ListTile(
                                contentPadding:
                                    EdgeInsets.only(left: 15, right: 5),
                                visualDensity: VisualDensity.compact,
                                leading: Icon(Icons.notifications,
                                    color: Colors.grey.shade600),
                                title: Text("Mute notifications"),
                                titleTextStyle: TextStyle(
                                    fontSize: 14, color: Colors.black),
                                trailing: Container(
                                  padding: EdgeInsets.zero,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                      activeTrackColor: tealGreenColor,
                                      activeColor: Colors.white,
                                      value:
                                          homeController.stopNotification.value,
                                      onChanged: (val) {
                                        homeController.stopNotification.value =
                                            val;
                                      },
                                    ),
                                  ),
                                )),
                            ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 15, right: 10),
                              visualDensity: VisualDensity.compact,
                              leading: Icon(Icons.music_note,
                                  color: Colors.grey.shade600),
                              title: Text("Custom notifications"),
                              titleTextStyle:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 15, right: 10),
                              visualDensity: VisualDensity.compact,
                              leading: Icon(Icons.image,
                                  color: Colors.grey.shade600),
                              title: Text("Media visibility"),
                              titleTextStyle:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Card(
                        shape: RoundedRectangleBorder(),
                        color: Colors.white,
                        elevation: 0.1,
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 15, right: 10),
                              visualDensity: VisualDensity.compact,
                              leading: Icon(Icons.block, color: Colors.red),
                              title: Text("Block ${chatuser.name}"),
                              titleTextStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600),
                            ),
                            ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 15, right: 10),
                              visualDensity: VisualDensity.compact,
                              leading:
                                  Icon(Icons.thumb_down, color: Colors.red),
                              title: Text("Report ${chatuser.name}"),
                              titleTextStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
