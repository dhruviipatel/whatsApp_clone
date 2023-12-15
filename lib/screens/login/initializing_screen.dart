import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/home/home_screen.dart';
import 'package:whatsapp_clone/utils/colors.dart';

class InitializingScreen extends StatelessWidget {
  const InitializingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    });
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 30, 25, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Center(
                    child: Text(
                      "Initializing...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: tealGreenColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Please wait a moment",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ],
              ),
              CircleAvatar(
                backgroundImage:
                    AssetImage('assets/images/landing_image_bg.jpg'),
                radius: 150,
              ),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(
                    color: tealGreenColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
