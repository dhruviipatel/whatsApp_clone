import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/colors.dart';

class InitializingScreen extends StatelessWidget {
  const InitializingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 25, vertical: size.width * 0.22),
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
            backgroundImage: AssetImage('assets/images/landing_image_bg.jpg'),
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
    );
  }
}
