import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      controller.changeTabIndex(tabController.index);
      print(controller.tabIndex);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.obxvalue == true
          ? Scaffold()
          : Scaffold(
              floatingActionButton: controller.tabIndex.value == 0
                  ? FloatingActionButton(
                      backgroundColor: tealDarkGreenColor,
                      onPressed: () {},
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
                              child:
                                  Icon(Icons.camera_alt, color: Colors.white),
                            ),
                          ],
                        )
                      : FloatingActionButton(
                          backgroundColor: tealDarkGreenColor,
                          onPressed: () {},
                          child: Icon(Icons.phone, color: Colors.white),
                        ),
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate1(Container(
                        // height: 100,
                        child: Text("1234"),
                      )),
                      pinned: true,
                      floating: true,
                    ),
                    home_appbar(),
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 50;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 50,
      color: tealDarkGreenColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class _SliverAppBarDelegate1 extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate1(this._container);

  final Container _container;

  @override
  double get minExtent => 50;
  @override
  double get maxExtent => 50;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 50,
      color: Colors.grey,
      child: _container,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
