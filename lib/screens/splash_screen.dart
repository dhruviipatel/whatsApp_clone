import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/landing_screen1.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LandingScreen1()),
          (route) => false);
    });
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Image.asset("assets/images/whatsapp.png"),
      ),
    ));
  }
}
