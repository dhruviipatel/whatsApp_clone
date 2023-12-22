import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/authController.dart';
import 'package:whatsapp_clone/models/chatuserModel.dart';
import 'package:whatsapp_clone/screens/home/home_widgets.dart';
import 'package:whatsapp_clone/utils/colors.dart';

Widget chatTab() {
  final ac = Get.find<AuthController>();
  return StreamBuilder(
      stream: ac.firestore
          .collection('users')
          .where('id', isNotEqualTo: ac.loginuser.value?.id)
          .snapshots(),
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
            list = data?.map((e) => Chatuser.fromJson(e.data())).toList() ?? [];

            if (list.isNotEmpty) {
              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return home_listTile(list[index]);
                      },
                      childCount: list.length,
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text("No contact to chat"),
              );
            }
        }
      });
}

Widget statusTab() {
  final ac = Get.find<AuthController>();
  return CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundImage:
                              NetworkImage(ac.loginuser.value?.image ?? ''),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 37,
                        top: 32,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              color: tealDarkGreenColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15,
                          )),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Status",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                      Text("Tap to add status update",
                          style: TextStyle(fontSize: 13))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 10),
          child: Text(
            'Recent updates',
            style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return status_listTile();
          },
          childCount: 100,
        ),
      ),
    ],
  );
}

Widget callsTab() {
  return CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Container(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: tealGreenColor,
                radius: 22,
                child: Icon(
                  Icons.link,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create call link",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  Text(
                    "Share a link for your WhatsApp call",
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ))
            ],
          ),
        ),
      )),
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            'Recent',
            style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return call_listTile();
          },
          childCount: 100,
        ),
      ),
    ],
  );
}
