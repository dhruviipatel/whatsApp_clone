import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/authController.dart';
import 'package:whatsapp_clone/controllers/homeController.dart';
import 'package:whatsapp_clone/utils/colors.dart';

Widget chatcard(message, context) {
  final homeController = Get.find<HomeController>();
  final ac = Get.find<AuthController>();
  if (message.read.isNotEmpty) {
    homeController.updateMessageRealStatus(message);
    print("message read updated");
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
              padding: message.msg.length < 8
                  ? EdgeInsets.fromLTRB(15, 5, 70, 20)
                  : EdgeInsets.fromLTRB(15, 5, 30, 20),
              child: Text(
                message.msg,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16),
              ),
            ),
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

Widget chatInput(controller, oppositeUser) {
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
                        onPressed: () {},
                        icon: Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.grey.shade600,
                        )),
                    Expanded(
                        child: TextFormField(
                      controller: controller,
                      cursorColor: tealDarkGreenColor,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onChanged: (value) {
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
                    homeController.chatText.value.length > 0
                        ? Container()
                        : IconButton(
                            onPressed: () {},
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
                        homeController.sendMessage(
                            oppositeUser, homeController.chatText.value);
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
