import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/models/chatuserModel.dart';
import 'package:whatsapp_clone/screens/chat/chat_screen.dart';
import 'package:whatsapp_clone/screens/profile/oppProfile_screen.dart';

class MemberClickDialog extends StatelessWidget {
  final Chatuser user;
  const MemberClickDialog({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(),
      //backgroundColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        height: MediaQuery.of(context).size.height * .15,
        width: MediaQuery.of(context).size.height * .6,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(() => ChatScreen(mychatuser: user));
                  },
                  child: Text("Message ${user.name}")),
              InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(() => OppProfileScreen(chatuser: user));
                  },
                  child: Text("View ${user.name}")),
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text("Verify security code"))
            ],
          ),
        ),
      ),
    );
  }
}
