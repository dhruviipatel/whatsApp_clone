import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/screens/contact/select_contact_screen.dart';
import 'package:whatsapp_clone/screens/home/home_widgets.dart';
import 'package:whatsapp_clone/screens/home/tabs.dart';
import 'package:whatsapp_clone/utils/colors.dart';
import 'package:whatsapp_clone/controllers/homeController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController controller = Get.put(HomeController());

  late TabController tabController;
  @override
  void initState() {
    //set user update status active when start app
    controller.updateOnlineStatus(true);

    SystemChannels.lifecycle.setMessageHandler((message) {
      log('message : $message');
      if (message.toString().contains('pause'))
        controller.updateOnlineStatus(false);
      if (message.toString().contains('resumed'))
        controller.updateOnlineStatus(true);
      return Future.value(message);
    });

    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      controller.changeTabIndex(tabController.index);
      print(controller.tabIndex);
    });
    super.initState();
    //}

    //set its active status when we open close apps dynamically
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButton: controller.tabIndex.value == 0
            ? FloatingActionButton(
                backgroundColor: tealDarkGreenColor,
                onPressed: () {
                  Get.to(() => SelectContactScareen());
                },
                child: Icon(Icons.message, color: Colors.white),
              )
            : controller.tabIndex.value == 1
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        backgroundColor: tealDarkGreenColor,
                        mini: true,
                        onPressed: () {},
                        child: Icon(Icons.edit, color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      FloatingActionButton(
                        backgroundColor: tealDarkGreenColor,
                        onPressed: () {},
                        child: Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    ],
                  )
                : FloatingActionButton(
                    backgroundColor: tealDarkGreenColor,
                    onPressed: () {},
                    child: Icon(Icons.phone, color: Colors.white),
                  ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              //for statusbar
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate1(Container(
                  child: Container(),
                )),
                pinned: true,
                floating: true,
              ),
              home_appbar(context),
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
                  TabBar(
                    controller: tabController,
                    labelStyle: TextStyle(fontWeight: FontWeight.w700),
                    unselectedLabelStyle:
                        TextStyle(fontWeight: FontWeight.w700),
                    labelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.white,
                    indicatorWeight: 4,
                    unselectedLabelColor: Colors.white.withOpacity(0.5),
                    tabs: [
                      Tab(text: "Chat"),
                      Tab(text: "Status"),
                      Tab(text: "Calls"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: [
              chatTab(),
              statusTab(),
              callsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
