import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
import 'dart:convert';

class RoleModel {
  int id;
  String name;
  String description;
  bool isActive;
  String createdAt;
  String updatedAt;

  RoleModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json["roles"]["id"],
      name: json["roles"]["name"],
      description: json["roles"]["description"],
      isActive: json["roles"]["is_active"],
      createdAt: json["roles"]["created_at"],
      updatedAt: json["roles"]["updated_at"],
    );
  }
}

class UserModel {
  String accessToken;
  String tokenType;
  int userId;
  String userName;
  String userSurname;
  String userEmail;
  bool userIsActive;
  bool userIsFirstLogin;
  List<RoleModel> roles;

  UserModel({
    required this.accessToken,
    required this.tokenType,
    required this.userId,
    required this.userName,
    required this.userSurname,
    required this.userEmail,
    required this.userIsActive,
    required this.userIsFirstLogin,
    required this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<RoleModel> roles = (json['roles'] as List)
        .map((roleJson) => RoleModel.fromJson(roleJson))
        .toList();

    return UserModel(
      accessToken: json["access_token"],
      tokenType: json["token_type"],
      userId: json["user"]["id"],
      userName: json["user"]["name"],
      userSurname: json["user"]["surname"],
      userEmail: json["user"]["email"],
      userIsActive: json["user"]["is_active"],
      userIsFirstLogin: json["user"]["is_first_login"],
      roles: roles,
    );
  }
}

Future<void> fetchUserData(String email, String password) async {
  final url = Uri.parse("http://192.168.1.76:8000/api/login");

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      String token = data["access_token"];

      print("Yeni token: $token");
    } else {
      final Map<String, dynamic> data = jsonDecode(response.body);

      String error = data["message"];

      print("İstek başarısız oldu: $error");
    }
  } catch (e) {
    print("bir hata oluştu: $e");
  }
}
