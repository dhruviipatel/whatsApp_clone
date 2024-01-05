import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/authController.dart';
import 'package:whatsapp_clone/controllers/homeController.dart';
import 'package:whatsapp_clone/utils/colors.dart';

class AddGroupInfoScreen extends StatelessWidget {
  const AddGroupInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final ac = Get.find<AuthController>();

    TextEditingController nameController = TextEditingController();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: tealDarkGreenColor,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New group",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                "Add subject",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: ContinuousRectangleBorder(),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        homeController.groupImage.value =
                            await ac.chooseImageFromGallery();
                      },
                      child: homeController.groupImage.value == ''
                          ? CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 22,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            )
                          : CircleAvatar(
                              radius: 22,
                              backgroundImage: FileImage(
                                  File(homeController.groupImage.value)),
                            ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 30,
                        child: TextFormField(
                          onTap: () {
                            if (homeController.showEmoji.value) {
                              homeController.showEmoji.value =
                                  !homeController.showEmoji.value;
                            }
                          },
                          onChanged: (value) {
                            nameController.text = value;
                          },
                          controller: nameController,
                          cursorHeight: 20,
                          cursorColor: tealGreenColor,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 14),
                              hintText: 'Type group subject here...',
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 14),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: tealGreenColor)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: tealGreenColor))),
                        ),
                      ),
                    )),
                    InkWell(
                      onTap: () {
                        homeController.showEmoji.value =
                            !homeController.showEmoji.value;
                      },
                      child: Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Members : ${homeController.selectedMemberList.length - 1}",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemCount: homeController.selectedMemberList.length - 1,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundImage: NetworkImage(homeController
                                .selectedMemberList[index + 1].image),
                          ),
                          Text(
                            homeController.selectedMemberList[index + 1].name,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      );
                    })),
            if (homeController.showEmoji.value)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.34,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    //homeController.chatText.value = messageController.text;
                  },
                  textEditingController: nameController,
                  config: Config(
                    columns: 8,
                    emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                  ),
                ),
              )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: tealDarkGreenColor,
          onPressed: () async {
            if (homeController.groupImage.value == '') {
              await ac.assetImageToFile('assets/images/emptyUser.jpg').then(
                  (myfile) => homeController.createGroup(
                      homeController.selectedMemberList,
                      nameController.text,
                      myfile));
            } else {
              homeController.createGroup(homeController.selectedMemberList,
                  nameController.text, File(homeController.groupImage.value));
            }
          },
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
