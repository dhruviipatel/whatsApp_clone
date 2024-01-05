import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/authController.dart';
import 'package:whatsapp_clone/controllers/homeController.dart';
import 'package:whatsapp_clone/models/chatuserModel.dart';
import 'package:whatsapp_clone/models/groupMessageModel.dart';
import 'package:whatsapp_clone/models/messageModel.dart';
import 'package:whatsapp_clone/utils/colors.dart';

Widget chatcard(message, context) {
  final homeController = Get.find<HomeController>();
  //final ac = Get.find<AuthController>();

  return Align(
    alignment: Alignment.centerRight,
    child: ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
      child: Card(
        color: mychatcolor,
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
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.network(
                          message.msg,
                          fit: BoxFit.contain,
                        ),
                      )),
            Positioned(
                bottom: 4,
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
                    message.read == ''
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
                  ],
                ))
          ],
        ),
      ),
    ),
  );
}

Widget oppChatCard(Message message, context) {
  final homeController = Get.find<HomeController>();
  final ac = Get.find<AuthController>();
  if (message.read.isEmpty) {
    homeController.updateMessageReadStatus(message);
    print("message read updated");
  }
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 5, left: 2),
        child: StreamBuilder(
            stream: ac.firestore
                .collection('users')
                .where('id', isEqualTo: message.fromId)
                .snapshots(),
            builder: (context, snapshot) {
              var data = snapshot.data?.docs;
              final list =
                  data?.map((e) => Chatuser.fromJson(e.data())).toList() ?? [];

              if (list.isNotEmpty) {
                Chatuser usr = list[0];

                return Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(usr.image), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(30),
                  ),
                );
              } else {
                return Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                );
              }
            }),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
          child: Card(
            color: Colors.white,
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.network(
                              message.msg,
                              fit: BoxFit.contain,
                            ),
                          )),
                Positioned(
                    bottom: 2,
                    right: 10,
                    child: Row(
                      children: [
                        Text(
                          homeController.getFormatedDate(
                              context: context, time: message.sent),
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                        ),
                        SizedBox(width: 5),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget groupchatcard(GroupMessage message, context) {
  final homeController = Get.find<HomeController>();
  //final ac = Get.find<AuthController>();

  return Align(
    alignment: Alignment.centerRight,
    child: ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
      child: Card(
        color: mychatcolor,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Stack(
          children: [
            Padding(
                padding: message.type == MType.image
                    ? EdgeInsets.fromLTRB(10, 10, 10, 30)
                    : message.msg.length < 8
                        ? EdgeInsets.fromLTRB(15, 5, 70, 20)
                        : EdgeInsets.fromLTRB(15, 5, 30, 20),
                child: message.type == MType.text
                    ? Text(
                        message.msg,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 16),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.network(
                          message.msg,
                          fit: BoxFit.contain,
                        ),
                      )),
            Positioned(
                bottom: 4,
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
                    Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.grey,
                    )
                  ],
                ))
          ],
        ),
      ),
    ),
  );
}

Widget oppGroupchatCard(GroupMessage message, context) {
  final homeController = Get.find<HomeController>();
  final ac = Get.find<AuthController>();

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 5, left: 2),
        child: StreamBuilder(
            stream: ac.firestore
                .collection('users')
                .where('id', isEqualTo: message.fromId)
                .snapshots(),
            builder: (context, snapshot) {
              var data = snapshot.data?.docs;
              final list =
                  data?.map((e) => Chatuser.fromJson(e.data())).toList() ?? [];

              if (list.isNotEmpty) {
                Chatuser usr = list[0];

                return Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(usr.image), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(30),
                  ),
                );
              } else {
                return Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                );
              }
            }),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
          child: Card(
            color: Colors.white,
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Stack(
              children: [
                Padding(
                    padding: message.type == MType.image
                        ? EdgeInsets.fromLTRB(10, 10, 10, 30)
                        : message.msg.length < 8
                            ? EdgeInsets.fromLTRB(15, 5, 70, 20)
                            : EdgeInsets.fromLTRB(15, 5, 30, 20),
                    child: message.type == MType.text
                        ? Text(
                            message.msg,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.network(
                              message.msg,
                              fit: BoxFit.contain,
                            ),
                          )),
                Positioned(
                    bottom: 2,
                    right: 10,
                    child: Row(
                      children: [
                        Text(
                          homeController.getFormatedDate(
                              context: context, time: message.sent),
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                        ),
                        SizedBox(width: 5),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget chatInput(controller, context, prevScreen, {oppositeUser, group}) {
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
                              // await homeController
                              //     .chooseImageFromCamera(oppositeUser);

                              final path = await ac.chooseImageFromGallery();

                              if (path != null) {
                                if (prevScreen == 'groupchat') {
                                  homeController.isUploading.value = true;
                                  homeController
                                      .sendGroupChatImage(group, File(path))
                                      .then((imgurl) =>
                                          homeController.sendGroupMessage(
                                              group, imgurl, MType.image));
                                  homeController.isUploading.value = false;
                                } else {
                                  homeController.isUploading.value = true;
                                  homeController
                                      .sendChatImage(oppositeUser, File(path))
                                      .then((imageurl) =>
                                          homeController.sendMessage(
                                              oppositeUser,
                                              imageurl,
                                              Type.image));
                                  homeController.isUploading.value = false;
                                }
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
                        if (prevScreen == 'groupchat') {
                          homeController.sendGroupMessage(
                              group, homeController.chatText.value, MType.text);
                          homeController.chatText.value = '';
                          controller.text = '';
                        } else {
                          homeController
                              .saveFirstMessageData(oppositeUser)
                              .then((value) {
                            homeController.sendMessage(oppositeUser,
                                homeController.chatText.value, Type.text);
                            homeController.chatText.value = '';
                            controller.text = '';
                          });
                        }
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












/////
///
// Widget chatcard(message, context) {
//   final homeController = Get.find<HomeController>();
//   final ac = Get.find<AuthController>();
//   if (ac.loginuser.value!.id != message.fromId) {
//     if (message.read.isEmpty) {
//       homeController.updateMessageReadStatus(message);
//       print("message read updated");
//     }
//   }

//   return Align(
//     alignment: ac.loginuser.value!.id == message.fromId
//         ? Alignment.centerRight
//         : Alignment.centerLeft,
//     child: ConstrainedBox(
//       constraints:
//           BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
//       child: Card(
//         color: ac.loginuser.value!.id == message.fromId
//             ? mychatcolor
//             : Colors.white,
//         elevation: 1,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//         child: Stack(
//           children: [
//             Padding(
//                 padding: message.type == Type.image
//                     ? EdgeInsets.fromLTRB(10, 10, 10, 30)
//                     : message.msg.length < 8
//                         ? EdgeInsets.fromLTRB(15, 5, 70, 20)
//                         : EdgeInsets.fromLTRB(15, 5, 30, 20),
//                 child: message.type == Type.text
//                     ? Text(
//                         message.msg,
//                         textAlign: TextAlign.start,
//                         style: TextStyle(fontSize: 16),
//                       )
//                     : Container(
//                         width: MediaQuery.of(context).size.width / 2,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20)),
//                         child: Image.network(
//                           message.msg,
//                           fit: BoxFit.contain,
//                         ),
//                       )),
//             Positioned(
//                 bottom: ac.loginuser.value!.id == message.fromId ? 4 : 2,
//                 right: 10,
//                 child: Row(
//                   children: [
//                     Text(
//                       homeController.getFormatedDate(
//                           context: context, time: message.sent),
//                       style:
//                           TextStyle(color: Colors.grey.shade600, fontSize: 13),
//                     ),
//                     SizedBox(width: 5),
//                     ac.loginuser.value!.id == message.fromId
//                         ? message.read == ''
//                             ? Icon(
//                                 Icons.done_all,
//                                 size: 16,
//                                 color: Colors.grey,
//                               )
//                             : Icon(
//                                 Icons.done_all,
//                                 size: 16,
//                                 color: Colors.blue,
//                               )
//                         : Container()
//                   ],
//                 ))
//           ],
//         ),
//       ),
//     ),
//   );
// }
