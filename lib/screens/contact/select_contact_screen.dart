import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/homeController.dart';
import 'package:whatsapp_clone/screens/chat/chat_screen.dart';
import 'package:whatsapp_clone/screens/group/newgroup_screen.dart';
import 'package:whatsapp_clone/screens/profile/profile_widgets.dart';
import 'package:whatsapp_clone/utils/colors.dart';

import '../../controllers/authController.dart';
import '../../models/chatuserModel.dart';

class SelectContactScareen extends StatelessWidget {
  const SelectContactScareen({super.key});

  @override
  Widget build(BuildContext context) {
    final ac = Get.find<AuthController>();
    final homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: tealDarkGreenColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select contact",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              "344 contacts",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                if (ac.loginuser.value != null) {
                  var user = ac.loginuser.value;
                  homeController.selectedMemberList.add(user!);
                }

                Get.to(() => NewGroupScreen(
                      // ignore: invalid_use_of_protected_member
                      contactlist: homeController.contactList.value,
                    ));
              },
              child: ListTile(
                visualDensity: VisualDensity.compact,
                leading: CircleAvatar(
                  backgroundColor: tealGreenColor,
                  radius: 18,
                  child: Icon(
                    Icons.group,
                    color: Colors.white,
                  ),
                ),
                title: Text("New Group"),
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
            ),
            ListTile(
              visualDensity: VisualDensity.compact,
              title: Text("Contacts on whatsapp"),
              titleTextStyle:
                  TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            StreamBuilder(
                stream: ac.firestore.collection('users').snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    //if data is loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    //if data is loaded and show it
                    case ConnectionState.active:
                    case ConnectionState.done:
                      List<Chatuser> list = [];

                      var data = snapshot.data?.docs;
                      homeController.contactList.clear();
                      list = data
                              ?.map((e) => Chatuser.fromJson(e.data()))
                              .toList() ??
                          [];

                      var list1 = data
                              ?.map((e) => Chatuser.fromJson(e.data()))
                              .where((user) =>
                                  user.id !=
                                  ac.loginuser.value
                                      ?.id) // Adjust the condition as needed
                              .toList() ??
                          [];
                      homeController.contactList.addAll(list1);

                      if (list.isNotEmpty) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                visualDensity: VisualDensity.compact,
                                leading: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => ProfileDialog(
                                            chatuser: list[index]));
                                  },
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(list[index].image),
                                    radius: 18,
                                  ),
                                ),
                                title: InkWell(
                                  onTap: () {
                                    //Get.offUntil((), (route) => false);
                                    Get.off(() => ChatScreen(
                                          mychatuser: list[index],
                                        ));
                                  },
                                  child: Text(
                                    list[index].id == ac.loginuser.value?.id
                                        ? 'Me (You)'
                                        : list[index].name,
                                  ),
                                ),
                                titleTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                                subtitle: InkWell(
                                  onTap: () {
                                    Get.off(() => ChatScreen(
                                          mychatuser: list[index],
                                        ));
                                  },
                                  child: Text(
                                      list[index].id == ac.loginuser.value?.id
                                          ? 'Message yourself'
                                          : list[index].about),
                                ),
                                subtitleTextStyle: TextStyle(
                                    fontSize: 12, color: Colors.grey.shade600),
                              );
                            });
                      } else {
                        return Center(
                          child: Text("No contact to chat"),
                        );
                      }
                  }
                }),
          ],
        ),
      ),
    );
  }
}
