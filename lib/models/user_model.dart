// import 'package:flutter/material.dart';

class UserRoleModel {
  int roleUserId;
  int roleRoleId;
  int userRoleIsActive;
  String userRoleStartDate;
  String? userRoleEndDate;
  String userRoleCreatedDate;
  String userRoleUpdateDate;

  UserRoleModel({
    required this.roleUserId,
    required this.roleRoleId,
    required this.userRoleIsActive,
    required this.userRoleStartDate,
    required this.userRoleEndDate,
    required this.userRoleCreatedDate,
    required this.userRoleUpdateDate,
  });

  factory UserRoleModel.fromJson(Map<String, dynamic> json) {
    return UserRoleModel(
      roleUserId: json["user_id"],
      roleRoleId: json["role_id"],
      userRoleIsActive: json["is_active"],
      userRoleStartDate: json["start_date"],
      userRoleEndDate: json["end_date"],
      userRoleCreatedDate: json["created_at"],
      userRoleUpdateDate: json["updated_at"],
    );
  }
}

class RoleModel {
  int id;
  String name;
  String description;
  bool isActive;
  String createdAt;
  String updatedAt;
  UserRoleModel userRoleModel;

  RoleModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.userRoleModel,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      isActive: json["is_active"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      userRoleModel: UserRoleModel.fromJson(json["pivot"]),
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

class LoginErrorModel {
  String? message;
  Map<String, List<String>>? errors;

  LoginErrorModel({this.message, this.errors});

  factory LoginErrorModel.fromJson(Map<String, dynamic> json) {
    return LoginErrorModel(
      message: json["message"],
      errors: json["errors"] != null
          ? (json["errors"] as Map<String, dynamic>)
              .map((key, value) => MapEntry(key, List<String>.from(value)))
          : null,
    );
  }

  String getFullErrorMessage() {
    if (message != null) {
      return message!;
    } else if (errors != null) {
      return errors!.entries.map((entry) {
        return "${entry.key}: ${entry.value.join(", ")}";
      }).join("\n");
    }
    return "Bilinmeyen bir hata oluştu";
  }
}

class FirstChanPassErrModel {
  String? message;
  Map<String, List<String>>? errors;

  FirstChanPassErrModel({this.message, this.errors});

  factory FirstChanPassErrModel.fromJson(Map<String, dynamic> json) {
    return FirstChanPassErrModel(
      message: json["message"],
      errors: json["errors"] != null
          ? (json["errors"] as Map<String, dynamic>)
              .map((key, value) => MapEntry(key, List<String>.from(value)))
          : null,
    );
  }

  String getFullErrorMessage() {
    if (message != null) {
      return message!;
    } else if (errors != null) {
      return errors!.entries.map((entry) {
        return "${entry.key}: ${entry.value.join(", ")}";
      }).join("\n");
    }
    return "Bilinmeyen bir hata oluştu";
  }
}

