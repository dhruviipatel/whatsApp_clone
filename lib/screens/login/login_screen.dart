import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/authController.dart';
import 'package:whatsapp_clone/screens/login/login_widgets.dart';
import 'package:whatsapp_clone/utils/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
    var mobileController = TextEditingController();

    return Obx(
      () => SafeArea(
        child: controller.isLoading == true
            ? Scaffold()
            : Scaffold(
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Text(
                                "Enter your phone number",
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
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                  text:
                                      'WhatsApp will send an SMS message to verify your phone number. ',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                                TextSpan(
                                  text: "What's my number?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue),
                                ),
                              ])),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: DropdownButton(
                                underline: Container(
                                  height: 1,
                                  color: tealGreenColor,
                                ),
                                iconDisabledColor: tealGreenColor,
                                iconEnabledColor: tealGreenColor,
                                value: controller.selectedCountry.value,
                                isExpanded: true,
                                items: controller.countryList.map((country) {
                                  return DropdownMenuItem(
                                    child: Text(country.countryName),
                                    value: country.countryName,
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  controller.selectedCountry.value =
                                      val as String;
                                  controller.getPhonecode(
                                      controller.selectedCountry.value);
                                  controller.update();
                                }),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 30,
                                  child: Center(
                                      child: Row(
                                    children: [
                                      Text(
                                        '+',
                                        style: TextStyle(
                                            color: Colors.grey.shade500),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        controller.selectedPhonecode.value,
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                                  decoration: BoxDecoration(
                                      //color: Colors.green,
                                      border: Border(
                                          bottom: BorderSide(
                                              color: lightgreenColor))),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: tealGreenColor))),
                                    child: TextFormField(
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                      keyboardType: TextInputType.number,
                                      controller: mobileController,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(top: 2),
                                          isCollapsed: true,
                                          hintText: 'Phone Number',
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide.none)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Carrier SMS charges may apply",
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2))),
                              onPressed: () {
                                loginDialog(
                                    context,
                                    controller.selectedPhonecode,
                                    mobileController.text);
                              },
                              child: Text(
                                "Next",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
