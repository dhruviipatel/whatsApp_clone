import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/login/login_screen.dart';

class LandingScreen1 extends StatelessWidget {
  const LandingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                "Welcome to WhatsApp",
                style: TextStyle(
                    color: const Color.fromARGB(255, 73, 145, 75),
                    fontSize: 30),
              )),
              CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage(
                  "assets/images/landing_image_bg.jpg",
                ),
              ),
              Column(
                children: [
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Read our ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.blue),
                        ),
                        TextSpan(
                          text: ' Tap "Agree and continue" to accept the',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: ' Terms of Service',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.blue),
                        ),
                      ])),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(
                                Size(MediaQuery.of(context).size.width, 45)),
                            textStyle: MaterialStatePropertyAll(
                                TextStyle(color: Colors.white)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                              (route) => false);
                        },
                        child: Text(
                          "AGREE TO CONTINUE",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
