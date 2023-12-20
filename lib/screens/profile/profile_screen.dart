import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/profile/profile_widgets.dart';
import 'package:whatsapp_clone/utils/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: tealDarkGreenColor,
        title: Text("Profile"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.05),
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.20,
                      backgroundImage: AssetImage('assets/images/user.jpg'),
                    ),
                  ),
                ),
                Positioned(
                    left: MediaQuery.of(context).size.width * 0.36,
                    top: MediaQuery.of(context).size.width * 0.32,
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.10,
                      width: MediaQuery.of(context).size.width * 0.10,
                      decoration: BoxDecoration(
                          color: tealGreenColor,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.10)),
                      child: Center(
                          child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.05,
                      )),
                    )),
              ],
            ),
            dataListTile(
                context, "Name", "Dhruvi 😇", Icons.account_circle, true),
            Divider(thickness: 0.5),
            dataListTile(context, "About", "Hey,i m using whatsapp",
                Icons.info_outline, true),
            Divider(
              thickness: 0.5,
            ),
            dataListTile(context, "Phone", "+91 1234567890", Icons.phone, false)
          ],
        ),
      ),
    );
  }
}
