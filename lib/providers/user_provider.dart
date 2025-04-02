import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sezin_scp/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  UserModel? _user;
  String? _errorMessage;
  bool _isLoading = false;
  bool _isPasswordLoading = false;
  String? _passwordErrorMessage;
  bool _isPasswordSucces = false;

  UserModel? get user => _user;
  String? get errormessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isPasswordLoading => _isPasswordLoading;
  String? get passwordErrorMessage => _passwordErrorMessage;
  bool get isPasswordSucces => _isPasswordSucces;

  Future<void> fetchUser(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final url = Uri.parse("http://127.0.0.1:8000/api/login/");
    // final url = Uri.parse("http://192.168.1.58:8000/api/login/");
    // final url = Uri.parse("http://192.168.1.208:8000/api/login/");
    // final url = Uri.parse("http://10.0.2.2:8000/api/login/");

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

      print("debug blok1");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("debug print response ${jsonDecode(response.body)}");
        final data = jsonDecode(response.body);
        print("debug blok2");
        _user = UserModel.fromJson(data);
        print("debug blok3");
      } else {
        print("Veri çekme işleminde hata, status code: ${response.statusCode}");
        final errorData = jsonDecode(response.body);
        print(errorData);
        _errorMessage =
            LoginErrorModel.fromJson(errorData).getFullErrorMessage();
        print("error data alındı");
      }
      print("debug blok4");
    } catch (e) {
      print("Bir hata oluştu: $e");
      _errorMessage =
          "Lütfen internet bağlantınızı kontrol edip tekrar deneyiniz. HATA\n $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> changeFirstPassword(
      String oldPassword, String newPassword, String newPasswordCheck, String token) async {
    _isPasswordLoading = true;
    _passwordErrorMessage = null;
    _isPasswordSucces = false;
    notifyListeners();

    final url = Uri.parse("http://127.0.0.1:8000/api/change-password/");
    // final url = Uri.parse("http://192.168.1.58:8000/api/change-password/");
    // final url = Uri.parse("http://192.168.1.208:8000/api/change-password/");
    // final url = Uri.parse("http://10.0.2.2:8000/api/change-password/");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "current_password": oldPassword,
          "new_password": newPassword,
          "new_password_confirmation": newPasswordCheck,
        }),
      );

      if (response.statusCode == 200) {
        _isPasswordSucces = true;
        print('Şifre başarıyla değiştirildi');
      } else {
        print('Şifre değiştirme işlemi başarısız: ${response.statusCode}');
        // _passwordErrorMessage = 'Şifre değiştirme işlemi başarısız: ${response.statusCode}\n Hata:${jsonDecode(response.body)}';
        // print(_passwordErrorMessage);
        final errorData = jsonDecode(response.body);
        _passwordErrorMessage = FirstChanPassErrModel.fromJson(errorData).getFullErrorMessage();
        print(errorData);
        print("error firs change password mesaj alındı");
      }
    } catch (e) {
      print("bir hata oluştu şifre değiştirme: $e");
    } finally {
      _isPasswordLoading = false;
      notifyListeners();
    }
  }

  Future<void> logOut (String token) async {
    
  }

}
