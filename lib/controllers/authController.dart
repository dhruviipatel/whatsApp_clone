import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/models/countryModel.dart';
import 'package:whatsapp_clone/utils/url.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    getCountry();
    super.onInit();
  }

  RxString selectedCountry = 'India'.obs;

  RxString username = ''.obs;

  List countryList = [];

  List phoneCodeList = [];

  RxBool isLoading = false.obs;
  getCountry() async {
    //get countrylist
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

    //  print(phoneCodeList);
  }

  RxString selectedPhonecode = '91'.obs;
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

  RxString profileimagepath = ''.obs;

  chooseProfilePicture() async {
    var myImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (myImage == null) {
      return;
    }
    //profileimagepath.value = myImage.path;
    return myImage.path;
  }
}
