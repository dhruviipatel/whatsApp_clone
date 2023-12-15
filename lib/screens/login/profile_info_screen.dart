import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/authController.dart';
import 'package:whatsapp_clone/screens/login/initializing_screen.dart';
import 'package:whatsapp_clone/utils/colors.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ac = Get.find<AuthController>();
    var nameController = TextEditingController();

    return Obx(
      () => SafeArea(
          child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25.0),
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
              Text("Please provide your name and an optional profile photo"),
              SizedBox(height: 30),
              InkWell(
                onTap: () async {
                  ac.profileimagepath.value = await ac.chooseProfilePicture();
                },
                child: ac.profileimagepath.value != ''
                    ? CircleAvatar(
                        backgroundImage:
                            FileImage(File(ac.profileimagepath.value)),
                        radius: 50,
                      )
                    : CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/blank_profile.jpg"),
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
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => InitializingScreen()),
                          (route) => false);
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
      )),
    );
  }
}