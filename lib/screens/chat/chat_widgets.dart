import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/authController.dart';
import 'package:whatsapp_clone/controllers/homeController.dart';
import 'package:whatsapp_clone/models/messageModel.dart';
import 'package:whatsapp_clone/utils/colors.dart';

Widget chatcard(message, context) {
  final homeController = Get.find<HomeController>();
  final ac = Get.find<AuthController>();
  if (ac.loginuser.value!.id != message.fromId) {
    if (message.read.isEmpty) {
      homeController.updateMessageReadStatus(message);
      print("message read updated");
    }
  }

  return Align(
    alignment: ac.loginuser.value!.id == message.fromId
        ? Alignment.centerRight
        : Alignment.centerLeft,
    child: ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
      child: Card(
        color: ac.loginuser.value!.id == message.fromId
            ? mychatcolor
            : Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Stack(
          children: [
            Padding(
                padding: message.type == Type.image
                    ? EdgeInsets.fromLTRB(10, 10, 10, 30)
                    : message.msg.length < 8
                        ? EdgeInsets.fromLTRB(15, 5, 70, 20)
                        : EdgeInsets.fromLTRB(15, 5, 30, 20),
                child: message.type == Type.text
                    ? Text(
                        message.msg,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 16),
                      )
                    : Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.network(
                          message.msg,
                          fit: BoxFit.contain,
                        ),
                      )),
            Positioned(
                bottom: ac.loginuser.value!.id == message.fromId ? 4 : 2,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      homeController.getFormatedDate(
                          context: context, time: message.sent),
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    ),
                    SizedBox(width: 5),
                    ac.loginuser.value!.id == message.fromId
                        ? message.read == ''
                            ? Icon(
                                Icons.done_all,
                                size: 16,
                                color: Colors.grey,
                              )
                            : Icon(
                                Icons.done_all,
                                size: 16,
                                color: Colors.blue,
                              )
                        : Container()
                  ],
                ))
          ],
        ),
      ),
    ),
  );
}

Widget chatInput(controller, oppositeUser, context) {
  final ac = Get.find<AuthController>();
  final homeController = Get.find<HomeController>();
  return Obx(
    () => Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/bg.jpg'))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          homeController.showEmoji.value =
                              !homeController.showEmoji.value;
                        },
                        icon: Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.grey.shade600,
                        )),
                    Expanded(
                        child: TextFormField(
                      onTap: () {
                        if (homeController.showEmoji.value) {
                          homeController.showEmoji.value =
                              !homeController.showEmoji.value;
                        }
                      },
                      controller: controller,
                      cursorColor: tealDarkGreenColor,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onChanged: (value) {
                        //controller.text = value;
                        homeController.chatText.value = value;
                      },
                      decoration: InputDecoration(
                          hintText: "Message",
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                    )),
                    IconButton(
                      onPressed: () {},
                      icon: Transform.rotate(
                        angle: 320 *
                            (3.141592653589793238462643383279502884 / 180),
                        child: Icon(
                          Icons.attach_file,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    //controller.text != ''
                    homeController.chatText.value.length > 0
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade600,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Icon(
                                  Icons.currency_rupee_sharp,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                    // controller.text != ''
                    homeController.chatText.value.length > 0
                        ? Container()
                        : IconButton(
                            onPressed: () async {
                              // homeController.selectedChatImg.value =
                              String selectedChatImg = await ac.chooseImage();
                              if (selectedChatImg.isNotEmpty) {
                                homeController.sendChatImage(
                                    oppositeUser, File(selectedChatImg));
                              }
                            },
                            icon: Icon(
                              Icons.photo_camera_rounded,
                              color: Colors.grey.shade600,
                            )),
                  ],
                ),
              ),
            ),
            homeController.chatText.value.length > 0
                ? InkWell(
                    onTap: () {
                      final chatUser = ac.loginuser.value;
                      if (chatUser != null) {
                        homeController.sendMessage(oppositeUser,
                            homeController.chatText.value, Type.text);
                        homeController.chatText.value = '';
                        controller.text = '';
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: tealGreenColor,
                          borderRadius: BorderRadius.circular(40)),
                      child: Center(
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: tealGreenColor,
                        borderRadius: BorderRadius.circular(40)),
                    child: Center(
                      child: Icon(
                        Icons.mic,
                        color: Colors.white,
                      ),
                    ),
                  )
          ],
        ),
      ),
    ),
  );
}
