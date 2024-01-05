import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/homeController.dart';
import 'package:whatsapp_clone/models/chatuserModel.dart';
import 'package:whatsapp_clone/models/messageModel.dart';
import 'package:whatsapp_clone/screens/profile/oppProfile_screen.dart';
import 'package:whatsapp_clone/utils/colors.dart';

Widget dataListTile(context, controller, title, subtitle, leadingIcon, isEdit) {
  return ListTile(
    visualDensity: VisualDensity.compact,
    leading: Icon(leadingIcon,
        size: MediaQuery.of(context).size.width * 0.06,
        color: Colors.grey.shade600),
    title: Text(title),
    titleTextStyle: TextStyle(color: Colors.grey.shade600, fontSize: 13),
    subtitle: isEdit
        ? Container(
            height: 24,
            child: Center(
              child: TextFormField(
                controller: controller,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                // initialValue: subtitle,
                cursorHeight: 15,
                cursorColor: tealDarkGreenColor,
                decoration: InputDecoration(
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
          )
        : Text(subtitle),
    subtitleTextStyle:
        TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
    trailing: isEdit
        ? Icon(Icons.edit,
            size: MediaQuery.of(context).size.width * 0.06,
            color: tealGreenColor)
        : Text(''),
  );
}

class ProfileDialog extends StatelessWidget {
  final Chatuser chatuser;
  const ProfileDialog({super.key, required this.chatuser});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * .35,
        width: MediaQuery.of(context).size.height * .6,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: Container(
                        child: Image.network(
                  chatuser.image,
                  fit: BoxFit.cover,
                ))),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.message, color: tealGreenColor),
                      Icon(Icons.call, color: tealGreenColor),
                      Icon(Icons.video_call, color: tealGreenColor),
                      InkWell(
                          onTap: () {
                            Get.back();
                            Get.to(() => OppProfileScreen(chatuser: chatuser));
                          },
                          child: Icon(Icons.info_outline_rounded,
                              color: tealGreenColor))
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  chatuser.name,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget oppDataContainer(icon, text, context) {
  return Container(
    height: MediaQuery.of(context).size.width / 5.5,
    width: MediaQuery.of(context).size.width / 5,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.5, color: Colors.grey.shade300)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: tealGreenColor),
        Text(text, style: TextStyle(fontSize: 13))
      ],
    ),
  );
}

Widget sharedImagesList(chatuser) {
  final homeController = Get.find<HomeController>();
  return StreamBuilder(
      stream: homeController.getAllMessages(chatuser),
      builder: (context, snapshot) {
        var data = snapshot.data?.docs;

        final list =
            data?.map((msg) => Message.fromJson(msg.data())).toList() ?? [];
        print(list);
        final imagelist =
            list.where((element) => element.type == Type.image).toList();
        if (imagelist.length == 0) {
          return Container();
        } else {
          return Card(
              shape: RoundedRectangleBorder(),
              color: Colors.white,
              elevation: 0.1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Media, links and docs',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600),
                        ),
                        Row(
                          children: [
                            Text(
                              "${imagelist.length}",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade600),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 12,
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: MediaQuery.of(context).size.width / 4,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imagelist.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Container(
                                  height: MediaQuery.of(context).size.width / 4,
                                  width: MediaQuery.of(context).size.width / 4,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              imagelist[index].msg),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ));
        }
      });
}
