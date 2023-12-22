import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/authController.dart';
import 'package:whatsapp_clone/screens/chat/chat_screen.dart';
import 'package:whatsapp_clone/screens/profile/profile_screen.dart';
import 'package:whatsapp_clone/utils/colors.dart';

import '../login/login_screen.dart';

Widget home_appbar(context) {
  final ac = Get.find<AuthController>();
  return SliverPersistentHeader(
    delegate: SliverAppBarDelegate1(Container(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "WhatsApp",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: PopupMenuButton(
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              onTap: () {
                                Get.to(() => ProfileScreen());
                              },
                              value: 'Profile',
                              child: Text('Profile'),
                            ),
                            PopupMenuItem<String>(
                              onTap: () => {},
                              value: 'Setting',
                              child: Text('Setting'),
                            ),
                            PopupMenuItem<String>(
                              onTap: () async {
                                await ac.logout(context);
                                Get.to(() => LoginScreen());
                              },
                              value: 'Logout',
                              child: Text('Logout'),
                            ),
                          ],
                      child: Icon(
                        Icons.more_vert_outlined,
                        color: Colors.white,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    )),
    pinned: true,
    floating: true,
  );
}

Widget home_listTile(user) {
  // String message = contact['message'];
  // String mymessage = '';
  // if (message.length > 40) {
  //   mymessage = message.substring(0, 40) + '...';
  // } else {
  //   mymessage = message;
  // }
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    child: Container(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.image),
            radius: 22,
          ),
          SizedBox(width: 15),
          Expanded(
              child: InkWell(
            onTap: () {
              Get.to(() => ChatScreen(
                    mychatuser: user,
                  ));
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${user.name}",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    Text(
                      '12:00 AM',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color: Colors.green),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user.about,
                      style: TextStyle(fontSize: 13),
                    ),
                    Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ))
        ],
      ),
    ),
  );
}

Widget status_listTile() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    child: Container(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/blank_profile.jpg'),
            radius: 22,
          ),
          SizedBox(width: 15),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dhruvi Patel",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              Text(
                "22 minutes ago",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ],
          ))
        ],
      ),
    ),
  );
}

Widget call_listTile() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    child: Container(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/blank_profile.jpg'),
            radius: 22,
          ),
          SizedBox(width: 15),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dhruvi Patel",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_outward_sharp,
                        size: 15,
                        color: Colors.green,
                      ),
                      Text(
                        " 22 minutes ago",
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(Icons.call, color: tealGreenColor)
            ],
          ))
        ],
      ),
    ),
  );
}

class SliverAppBarDelegate1 extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate1(this._container);

  final Container _container;

  @override
  double get minExtent => 50;
  @override
  double get maxExtent => 50;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 50,
      color: tealDarkGreenColor,
      child: _container,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 50;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 50,
      color: tealDarkGreenColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
