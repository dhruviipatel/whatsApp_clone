import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/screens/home/home_widgets.dart';

class HomeController extends GetxController {
  // Rx variable to hold the current tab index
  var tabIndex = 0.obs;

  var obxvalue = false.obs;

  // final TabController tabController =
  //     TabController(length: 3, vsync: AnimatedListOfHomeScreens());
  // final ScrollController scrollController = ScrollController();

  // Method to change the tab index
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
