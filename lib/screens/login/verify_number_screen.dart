import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/authController.dart';
import 'package:whatsapp_clone/screens/login/login_screen.dart';
import 'package:whatsapp_clone/screens/login/profile_info_screen.dart';
import 'package:whatsapp_clone/utils/colors.dart';

class VerifyNumberScreen extends StatelessWidget {
  final String phone;
  const VerifyNumberScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    final ac = Get.find<AuthController>();
    var otpController = TextEditingController();
    int myotp = 123456;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(
                    "Verify +${ac.selectedPhonecode} $phone",
                    style: TextStyle(
                        color: tealGreenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  Icon(
                    Icons.more_vert_outlined,
                    color: Colors.grey.shade700,
                  )
                ],
              ),
              SizedBox(height: 20),
              Text("Waiting to automatically detect an SMS sent to "),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "+${ac.selectedPhonecode} $phone",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    },
                    child: Text(
                      " Wrong number?",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 40,
                width: 180,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: otpController,
                  cursorColor: tealGreenColor,
                  cursorHeight: 20,
                  onChanged: (value) {
                    if (value.length == 6) {
                      if (value == myotp.toString()) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileInfoScreen()),
                            (route) => false);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please enter valid otp")));
                      }
                    }
                  },
                  decoration: InputDecoration(
                      isCollapsed: true,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: tealGreenColor)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: tealGreenColor))),
                ),
              ),
              Text(
                "Enter 6-digit code",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
              ListTile(
                //horizontalTitleGap: 0,
                visualDensity: VisualDensity.compact,
                titleTextStyle: TextStyle(color: Colors.grey.shade500),
                leading: Icon(
                  Icons.message,
                  color: Colors.grey.shade300,
                  size: 20,
                ),
                title: Text(
                  'Resend SMS',
                ),
                trailing: Text(
                  "2:04",
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ),
              Divider(),
              ListTile(
                visualDensity: VisualDensity.compact,
                titleTextStyle: TextStyle(color: Colors.grey.shade500),
                leading: Icon(
                  Icons.call,
                  color: Colors.grey.shade300,
                  size: 20,
                ),
                title: Text(
                  'Call me',
                ),
                trailing: Text(
                  "2:04",
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
