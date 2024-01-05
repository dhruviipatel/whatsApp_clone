import 'dart:convert';

GroupMessage groupmessageFromJson(String str) =>
    GroupMessage.fromJson(json.decode(str));

String groupmessageToJson(GroupMessage data) => json.encode(data.toJson());

class GroupMessage {
  String fromId;
  String msg;
  String sent;
  String groupId;
  MType type;

  GroupMessage({
    required this.fromId,
    required this.msg,
    required this.sent,
    required this.groupId,
    required this.type,
  });

  factory GroupMessage.fromJson(Map<String, dynamic> json) => GroupMessage(
        fromId: json["fromId"],
        msg: json["msg"],
        sent: json["sent"],
        groupId: json["groupId"],
        type: json["type"] == MType.image.name ? MType.image : MType.text,
      );

  Map<String, dynamic> toJson() => {
        "fromId": fromId,
        "msg": msg,
        "sent": sent,
        "groupId": groupId,
        "type": type.name,
      };
}

enum MType { text, image }
