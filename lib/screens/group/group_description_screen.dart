import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/authController.dart';
import 'package:whatsapp_clone/models/chatuserModel.dart';
import 'package:whatsapp_clone/models/groupModel.dart';
import 'package:whatsapp_clone/screens/group/group_widgets.dart';
import 'package:whatsapp_clone/utils/colors.dart';

import '../../controllers/homeController.dart';
import '../profile/profile_widgets.dart';

class GroupDescScreen extends StatelessWidget {
  final Group group;
  const GroupDescScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final AuthController ac = Get.find<AuthController>();
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
                                image: NetworkImage(group.groupImage),
                                fit: BoxFit.cover),
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width / 3)),
                      ),
                      Text(
                        group.groupName,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Group member count',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade700),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width / 6,
                              width: MediaQuery.of(context).size.width / 2.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey.shade300)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.message, color: tealGreenColor),
                                  Text("Message",
                                      style: TextStyle(fontSize: 13))
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width / 6,
                              width: MediaQuery.of(context).size.width / 2.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey.shade300)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.call, color: tealGreenColor),
                                  Text("Audio", style: TextStyle(fontSize: 13))
                                ],
                              ),
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
                          title: Text('About'),
                          titleTextStyle:
                              TextStyle(fontSize: 14, color: Colors.black),
                          subtitleTextStyle: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ),
                      SizedBox(height: 5),
                      sharedImagesList(group: group, isgroup: true),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${group.members.length} members",
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                            Icon(Icons.search, color: Colors.grey.shade700)
                          ],
                        ),
                      ),
                      ListTile(
                        visualDensity: VisualDensity.compact,
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(ac.loginuser.value!.image),
                        ),
                        title: Text("You"),
                        subtitle: Text(
                          '${ac.loginuser.value!.about}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),
                      for (var i = 0; i < group.members.length; i++)
                        StreamBuilder(
                            stream: ac.firestore
                                .collection('users')
                                .where('id', isEqualTo: group.members[i])
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data?.docs;
                                final list = data
                                        ?.map(
                                            (e) => Chatuser.fromJson(e.data()))
                                        .toList() ??
                                    [];
                                if (list.isNotEmpty) {
                                  if (list[0].id == ac.loginuser.value?.id) {
                                    return Container();
                                  } else {
                                    return ListTile(
                                      visualDensity: VisualDensity.compact,
                                      leading: InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  ProfileDialog(
                                                      chatuser: list[0]));
                                        },
                                        child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(list[0].image),
                                        ),
                                      ),
                                      title: InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    MemberClickDialog(
                                                      user: list[0],
                                                    ));
                                          },
                                          child: Text("${list[0].name}")),
                                      subtitle: Text(
                                        '${list[0].about}',
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                    );
                                  }
                                }
                              }
                              return ListTile(
                                title: Text(""),
                              );
                            }),
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
                              leading: Icon(Icons.logout, color: Colors.red),
                              title: Text("Exit group"),
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
                              title: Text("Report group"),
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
