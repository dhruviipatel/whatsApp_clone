import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/authController.dart';
import 'package:whatsapp_clone/utils/colors.dart';

loginDialog(BuildContext context, contrycode, number) {
  var authcontroller = Get.find<AuthController>();
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
                    try {
                      Navigator.pop(context);
                      authcontroller.verifyPhoneNumber(
                          '+${contrycode}', number, context);
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(color: tealGreenColor),
                  ))
            ],
          ));
}
