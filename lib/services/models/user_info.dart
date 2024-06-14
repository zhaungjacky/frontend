// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  String? id;
  String name;
  String email;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserInfo({
    this.id,
    required this.name,
    required this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "name": name,
        "email": email,
        // "createdAt": createdAt ?? DateTime.now(),
        // "updatedAt": updatedAt ?? DateTime.now(),
      };
}
