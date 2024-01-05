import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/authController.dart';
import 'package:whatsapp_clone/utils/colors.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ac = Get.find<AuthController>();
    var nameController = TextEditingController();
    var size = MediaQuery.of(context).size;

    return Obx(
      () => Scaffold(
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 25, vertical: size.width * 0.22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Profile Info",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: tealGreenColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Please provide your name and an optional profile photo",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () async {
                  ac.profileimagepath.value = await ac.chooseImageFromGallery();
                },
                child: ac.profileimagepath.value != ''
                    ? CircleAvatar(
                        backgroundImage:
                            FileImage(File(ac.profileimagepath.value)),
                        radius: 50,
                      )
                    : CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/emptyUser.jpg"),
                        radius: 50,
                      ),
              ),
              SizedBox(height: 20),
              Container(
                height: 30,
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          suffix: Text(
                            ac.username.value.length.toString(),
                            selectionColor: Colors.grey,
                            style: TextStyle(fontSize: 14),
                          ),
                          isCollapsed: true,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5, color: tealGreenColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5, color: tealGreenColor))),
                      onChanged: (value) {
                        ac.username.value = value;
                      },
                    )),
                    Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2))),
                  onPressed: () {
                    if (nameController.text.length > 0) {
                      if (ac.profileimagepath.value == '') {
                        ac.createNewUser(nameController.text);
                      } else {
                        ac.createNewUser(nameController.text,
                            file: File(ac.profileimagepath.value));
                      }

                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //       builder: (context) => InitializingScreen()),
                      // );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please Enter Username")));
                    }
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
