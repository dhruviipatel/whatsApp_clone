import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/authController.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController ac = Get.put(AuthController());
    Timer(const Duration(seconds: 2), () {
      ac.checkUserLoginStatus();
    });
    return Obx(
      () => ac.hasInternet == false
          ? Scaffold(
              body: Center(
                child: Text("No Internet Found"),
              ),
            )
          : Scaffold(
              body: Center(
                child: Image.asset("assets/images/whatsapp.png"),
              ),
            ),
    );
  }
}
