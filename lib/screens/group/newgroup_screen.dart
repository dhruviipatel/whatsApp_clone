import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/homeController.dart';
import 'package:whatsapp_clone/screens/group/group_info_screen.dart';
import 'package:whatsapp_clone/utils/colors.dart';
import '../../controllers/authController.dart';

class NewGroupScreen extends StatelessWidget {
  final List contactlist;
  const NewGroupScreen({super.key, required this.contactlist});

  @override
  Widget build(BuildContext context) {
    final ac = Get.find<AuthController>();
    final homeController = Get.find<HomeController>();
    return Obx(
      () => homeController.obxvalue == true
          ? Scaffold()
          : Scaffold(
              appBar: AppBar(
                centerTitle: false,
                titleSpacing: 0,
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: tealDarkGreenColor,
                leading: InkWell(
                    onTap: () {
                      Get.back();
                      homeController.selectedMemberList = [];
                    },
                    child: Icon(Icons.arrow_back_ios)),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Group",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      homeController.selectedMemberList.length == 1
                          ? "Add members"
                          : "${homeController.selectedMemberList.length - 1} of ${contactlist.length} selected ",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
                actions: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    homeController.selectedMemberList.length > 1
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  itemCount:
                                      homeController.selectedMemberList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    if (homeController
                                            .selectedMemberList[index].id !=
                                        ac.loginuser.value?.id) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: InkWell(
                                          onTap: () {
                                            homeController.addRemoveMember(
                                                homeController
                                                    .selectedMemberList[index]);
                                          },
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          homeController
                                                              .selectedMemberList[
                                                                  index]
                                                              .image),
                                                      radius: 22,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 2,
                                                    right: 0,
                                                    child: Container(
                                                      height: 18,
                                                      width: 18,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white),
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18)),
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                        size: 12,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                homeController
                                                    .selectedMemberList[index]
                                                    .name,
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                            ),
                          )
                        : Container(),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: contactlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              homeController
                                  .addRemoveMember(contactlist[index]);
                            },
                            child: ListTile(
                              visualDensity: VisualDensity.compact,
                              leading: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          contactlist[index].image),
                                      radius: 20,
                                    ),
                                  ),
                                  if (homeController.selectedMemberList.any(
                                      (element) =>
                                          element.id == contactlist[index].id))
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        height: 18,
                                        width: 18,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                              title: Text(
                                contactlist[index].name,
                              ),
                              titleTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                              subtitle: Text(contactlist[index].about),
                              subtitleTextStyle: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade600),
                            ),
                          );
                        }),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: tealDarkGreenColor,
                onPressed: () {
                  Get.to(() => AddGroupInfoScreen());
                },
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
