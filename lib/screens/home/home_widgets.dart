import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/screens/chat/chat_screen.dart';
import 'package:whatsapp_clone/utils/colors.dart';

Widget home_appbar() {
  return SliverAppBar(
    backgroundColor: tealDarkGreenColor,
    flexibleSpace: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "WhatsApp",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert_outlined,
                  color: Colors.white,
                ))
          ],
        )
      ],
    ),
  );
}

Widget home_listTile(contact) {
  String message = contact['message'];
  String mymessage = '';
  if (message.length > 50) {
    mymessage = message.substring(0, 50) + '...';
  } else {
    mymessage = message;
  }
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    child: Container(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(contact['profilePic']),
            radius: 22,
          ),
          SizedBox(width: 15),
          Expanded(
              child: InkWell(
            onTap: () {
              Get.to(() => ChatScreen(
                    contactname: contact['name'],
                    profilepic: contact['profilePic'],
                  ));
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${contact['name']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    Text(
                      '${contact['time']}',
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
                      mymessage,
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
