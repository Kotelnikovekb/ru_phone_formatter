import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  String success;
  String admin;
  String role;
  String name;
  String avatar;
  String id;

  UserDataModel({
    required this.success,
    required this.admin,
    required this.role,
    required this.name,
    required this.avatar,
    required this.id,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    success: json["success"],
    admin: json["admin"],
    role: json["role"],
    name: json["name"],
    avatar: json["avatar"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "admin": admin,
    "role": role,
    "name": name,
    "avatar": avatar,
    "id": id,
  };
}
