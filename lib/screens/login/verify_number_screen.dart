import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:whatsapp_clone/controllers/authController.dart';
import 'package:whatsapp_clone/screens/login/initializing_screen.dart';
import 'package:whatsapp_clone/screens/login/login_screen.dart';
import 'package:whatsapp_clone/utils/colors.dart';

class VerifyNumberScreen extends StatelessWidget {
  final String phone;
  const VerifyNumberScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    final ac = Get.find<AuthController>();

    var size = MediaQuery.of(context).size;
    return Obx(
      () => ac.isLoading == true
          ? Scaffold(body: InitializingScreen())
          : Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 25, vertical: size.width * 0.22),
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
                            Get.offAll(() => LoginScreen());
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
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: tealGreenColor))),
                      child: Pinput(
                        length: 6,
                        defaultPinTheme: PinTheme(
                            textStyle: TextStyle(fontSize: 19),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0, color: Colors.white))),
                        onCompleted: (value) async {
                          await ac.verifyOtp(value.toString(), context);
                        },
                      ),
                    ),
                    SizedBox(height: 10),
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
