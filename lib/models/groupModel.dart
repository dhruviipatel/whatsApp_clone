import 'dart:convert';

import 'package:whatsapp_clone/models/chatuserModel.dart';

Group groupFromJson(String str) => Group.fromJson(json.decode(str));

String groupToJson(Group data) => json.encode(data.toJson());

class Group {
  String groupId;
  String groupImage;
  String groupName;
  List<String> admins;
  List<Chatuser> members;

  Group({
    required this.groupId,
    required this.groupImage,
    required this.groupName,
    required this.admins,
    required this.members,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        groupId: json["groupId"],
        groupImage: json["groupImage"],
        groupName: json["groupName"],
        admins: List<String>.from(json["admins"].map((x) => x)),
        members: List<Chatuser>.from(
            json["members"].map((x) => Chatuser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "groupImage": groupImage,
        "groupName": groupName,
        "admins": List<dynamic>.from(admins.map((x) => x)),
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
      };
}
