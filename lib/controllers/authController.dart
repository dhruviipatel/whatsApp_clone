import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_clone/models/chatuserModel.dart';
import 'package:whatsapp_clone/models/countryModel.dart';
import 'package:whatsapp_clone/screens/home/home_screen.dart';
import 'package:whatsapp_clone/screens/login/login_screen.dart';
import 'package:whatsapp_clone/screens/login/profile_info_screen.dart';
import 'package:whatsapp_clone/screens/login/verify_number_screen.dart';
import 'package:whatsapp_clone/utils/url.dart';
import 'package:image/image.dart' as img;

class AuthController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  RxString selectedCountry = 'India'.obs;
  RxString username = ''.obs;
  List countryList = [];
  List phoneCodeList = [];
  RxBool isLoading = false.obs;
  RxString verId = ''.obs;
  RxString selectedPhonecode = '91'.obs;
  RxString profileimagepath = ''.obs;
  RxBool hasInternet = true.obs;

  //check if user login or not
  void checkUserLoginStatus() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await InternetAddress.lookup('google.com');
      if (user != null) {
        // User is already logged in
        hasInternet.value = true;
        Get.offAll(() => HomeScreen());
      } else {
        // User is not logged in
        hasInternet.value = true;
        Get.offAll(() => LoginScreen());
      }
    } catch (e) {
      hasInternet.value = false;
      print('No internet access');
    }
  }

  //get all country and phone code
  getCountry() async {
    try {
      isLoading.value = true;
      var response = await http.get(Uri.parse(countryListUrl));
      var countrylistData = jsonDecode(response.body);

      countryList = countrylistData.entries.map((entry) {
        return CountryList(
          countryCode: entry.key,
          countryName: entry.value,
        );
      }).toList();

      //get phonecode list
      var response1 = await http.get(Uri.parse(phoneCodeUrl));
      var phoneCodedata = jsonDecode(response1.body);

      phoneCodeList = phoneCodedata.entries.map((entry) {
        return PhoneCodeList(countryCode: entry.key, phoneCode: entry.value);
      }).toList();

      isLoading.value = false;
    } catch (e) {
      GetSnackBar(titleText: Text(e.toString()));
    }
  }

  //get country phone code base on selected country
  getPhonecode(String mycountry) {
    for (var c in countryList) {
      if (c.countryName == mycountry) {
        for (var code in phoneCodeList) {
          if (c.countryCode == code.countryCode) {
            selectedPhonecode.value = code.phoneCode;
            print(selectedPhonecode);
          }
        }
      }
    }
  }

  //choose image for profile
  chooseProfilePicture() async {
    var myImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (myImage == null) {
      return;
    }
    return myImage.path;
  }

  //user logout
  logout(context) async {
    await auth.signOut();
  }

  //verify phone number
  verifyPhoneNumber(countrycode, phoneNo, context) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '${countrycode + phoneNo}',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          } else {
            print(e.toString());
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          verId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Otp sent successfully")));

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => VerifyNumberScreen(phone: phoneNo)),
          (route) => false);
    } catch (e) {
      print(e);
    }
  }

  //verify otp
  verifyOtp(otpcode, context) async {
    isLoading.value = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verId.value, smsCode: otpcode);

      await auth.signInWithCredential(credential);

      isLoading.value = false;
      checkUserExist().then((value) {
        if (value == true) {
          Get.offAll(() => HomeScreen());
        } else {
          Get.offAll(() => ProfileInfoScreen());
        }
      });
    } catch (e) {
      isLoading.value = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid OTP")));
      print(e.toString());
    }
  }

  //check user already exist or not
  Future<bool> checkUserExist() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.phoneNumber.toString())
            .get())
        .exists;
  }

  //store file to firebase storage
  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    // print('download url: $downloadUrl');
    return downloadUrl;
  }

  //create new user and check if user selected image or not
  createNewUser(String name, {File? file}) async {
    if (file != null) {
      addNewUserData(name, file);
    } else {
      await assetImageToFile("assets/images/emptyUser.jpg").then((value) {
        print(value);
        addNewUserData(name, value);
      });
      ;
    }
  }

  // if image not selected add asset default image
  Future<File> assetImageToFile(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    var bytes = data.buffer.asUint8List();
    img.Image? image = img.decodeImage(Uint8List.fromList(bytes));
    int quality = 90;
    img.Image compressedImage = img.copyResize(image!,
        width: image.width,
        height: image.height,
        interpolation: img.Interpolation.linear);
    List<int> compressedBytes =
        img.encodeJpg(compressedImage, quality: quality);

    File file = File('${(await getTemporaryDirectory()).path}/temp_image.jpg');
    await file.writeAsBytes(compressedBytes);

    print(file);
    return file;
  }

  //add new user data in firebase
  addNewUserData(String name, File file) async {
    try {
      await storeFileToStorage(
              'profileImage/${auth.currentUser!.phoneNumber.toString()}', file)
          .then((value) {
        print(value);
        var time = DateTime.now().millisecondsSinceEpoch.toString();
        final Chatuser chatuser = Chatuser(
            isOnline: false,
            id: auth.currentUser!.phoneNumber.toString(),
            createdAt: time.toString(),
            pushToken: '',
            image: value,
            phone: auth.currentUser!.phoneNumber.toString(),
            about: 'Hey there,I am using WhatsApp ',
            lastActive: time.toString(),
            name: name);

        firestore
            .collection('users')
            .doc(auth.currentUser!.phoneNumber.toString())
            .set(chatuser.toJson())
            .then((value) => Get.offAll(HomeScreen()));
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
