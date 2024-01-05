import 'dart:convert';

Chatuser chatuserFromJson(String str) => Chatuser.fromJson(json.decode(str));

String chatuserToJson(Chatuser data) => json.encode(data.toJson());

class Chatuser {
  bool isOnline;
  String id;
  String createdAt;
  String pushToken;
  String image;
  String phone;
  String about;
  String lastActive;
  String name;
  List<String>? groups;

  Chatuser(
      {required this.isOnline,
      required this.id,
      required this.createdAt,
      required this.pushToken,
      required this.image,
      required this.phone,
      required this.about,
      required this.lastActive,
      required this.name,
      this.groups});

  factory Chatuser.fromJson(Map<String, dynamic> json) => Chatuser(
        isOnline: json["is_online"],
        id: json["id"],
        createdAt: json["created_at"],
        pushToken: json["push_token"],
        image: json["image"],
        phone: json["phone"],
        about: json["about"],
        lastActive: json["last_active"],
        name: json["name"],
        groups: json["groups"] != null
            ? List<String>.from(json["groups"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "is_online": isOnline,
        "id": id,
        "created_at": createdAt,
        "push_token": pushToken,
        "image": image,
        "phone": phone,
        "about": about,
        "last_active": lastActive,
        "name": name,
        "groups":
            groups != null ? List<dynamic>.from(groups!.map((x) => x)) : null,
      };
}
