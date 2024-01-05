import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/authController.dart';
import 'package:whatsapp_clone/screens/profile/profile_widgets.dart';
import 'package:whatsapp_clone/utils/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ac = Get.find<AuthController>();
    TextEditingController nameController =
        TextEditingController(text: ac.loginuser.value!.name);
    TextEditingController aboutController =
        TextEditingController(text: ac.loginuser.value!.about);

    TextEditingController phoneController =
        TextEditingController(text: ac.loginuser.value!.phone);
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                ac.isLoading.value = true;
                if (ac.profileimagepath.value != '') {
                  ac.assetImageToFile(ac.profileimagepath.value).then((val) =>
                      ac
                          .storeFileToStorage(
                              'profileImage/${ac.loginuser.value!.phone}', val)
                          .then((img) {
                        ac.updateUserData(
                            nameController.text, aboutController.text, img);
                        Navigator.pop(context);
                        ac.isLoading.value = false;
                        ac.profileimagepath.value = '';
                      }));
                } else {
                  ac.updateUserData(nameController.text, aboutController.text,
                      ac.loginuser.value!.image);
                  ac.isLoading.value = false;
                  Navigator.pop(context);
                }
              },
              child: Icon(Icons.arrow_back_ios)),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: tealDarkGreenColor,
          title: Text("Profile"),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          centerTitle: false,
        ),
        body: ac.isLoading.value == true
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Saving"),
                    SizedBox(height: 5),
                    CircularProgressIndicator(
                      color: tealDarkGreenColor,
                    ),
                  ],
                ),
              )
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        ac.profileimagepath.value =
                            await ac.chooseImageFromGallery();
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ac.profileimagepath.value != ''
                              ? Container(
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.05),
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.20,
                                      backgroundImage: FileImage(
                                          File(ac.profileimagepath.value)),
                                    ),
                                  ),
                                )
                              : Container(
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.05),
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.20,
                                      backgroundImage: NetworkImage(
                                          ac.loginuser.value!.image),
                                    ),
                                  ),
                                ),
                          Positioned(
                              left: MediaQuery.of(context).size.width * 0.36,
                              top: MediaQuery.of(context).size.width * 0.32,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.10,
                                width: MediaQuery.of(context).size.width * 0.10,
                                decoration: BoxDecoration(
                                    color: tealGreenColor,
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.10)),
                                child: Center(
                                    child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size:
                                      MediaQuery.of(context).size.width * 0.05,
                                )),
                              )),
                        ],
                      ),
                    ),
                    dataListTile(context, nameController, "Name",
                        ac.loginuser.value!.name, Icons.person, true),
                    Divider(thickness: 0.5),
                    dataListTile(context, aboutController, "About",
                        ac.loginuser.value!.about, Icons.info_outline, true),
                    Divider(
                      thickness: 0.5,
                    ),
                    dataListTile(context, phoneController, "Phone",
                        ac.loginuser.value!.phone, Icons.phone, false)
                  ],
                ),
              ),
      ),
    );
  }
}
