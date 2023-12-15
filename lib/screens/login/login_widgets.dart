import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/screens/login/verify_number_screen.dart';
import 'package:whatsapp_clone/utils/colors.dart';

// Widget loginDialog(){
//   return
// }

loginDialog(BuildContext context, contrycode, number) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceBetween,
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
            titleTextStyle: TextStyle(fontSize: 15, color: Colors.black),
            title: Text('We will be verifying the phone number:'),
            content: Container(
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '+' + contrycode.toString() + ' ' + number,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Is this OK, or would you like to edit the number?'),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Edit",
                    style: TextStyle(color: tealGreenColor),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                VerifyNumberScreen(phone: number)),
                        (route) => false);
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(color: tealGreenColor),
                  ))
            ],
          ));
}
