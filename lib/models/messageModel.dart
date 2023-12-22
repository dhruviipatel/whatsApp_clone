import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  String fromId;
  String msg;
  String read;
  String sent;
  String toId;
  Type type;

  Message({
    required this.fromId,
    required this.msg,
    required this.read,
    required this.sent,
    required this.toId,
    required this.type,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        fromId: json["fromId"],
        msg: json["msg"],
        read: json["read"],
        sent: json["sent"],
        toId: json["toId"],
        type: json["type"] == Type.image.name ? Type.image : Type.text,
      );

  Map<String, dynamic> toJson() => {
        "fromId": fromId,
        "msg": msg,
        "read": read,
        "sent": sent,
        "toId": toId,
        "type": type.name,
      };
}

enum Type { text, image }
