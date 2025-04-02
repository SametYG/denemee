// import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurePreferences {
  static final _secureStorage = FlutterSecureStorage();
  static encrypt.Key? _key;

  static Future<void> _initializeKey() async {
    if (_key == null) {
      final keyString = await _secureStorage.read(key: 'encryption_key');
      if (keyString == null) {
        final newKey = encrypt.Key.fromSecureRandom(32);
        await _secureStorage.write(
            key: 'encryption_key', value: base64Encode(newKey.bytes));
        _key = newKey;
      } else {
        _key = encrypt.Key(base64Decode(keyString));
      }
    }
  }

  static Future<String> encryptData(String value) async {
    await _initializeKey();
    final iv = encrypt.IV.fromSecureRandom(16);
    final encrypter = encrypt.Encrypter(
        encrypt.AES(_key!, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final encrypted = encrypter.encrypt(value, iv: iv);

    return jsonEncode({"iv": iv.base64, "value": encrypted.base64});
  }

  static Future<String?> decryptData(String encryptedJson) async {
    await _initializeKey();
    try {
      final jsonMapTrial = jsonDecode(encryptedJson);
      final jsonMap = jsonDecode(encryptedJson);
      print("Trial: $jsonMapTrial");
      final ivTrial = encrypt.IV.fromBase64(jsonMapTrial["iv"]);
      final encrypterTrial = encrypt.Encrypter(
          encrypt.AES(_key!, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
      final decryptedTrial =
          encrypterTrial.decrypt64(jsonMapTrial["value"], iv: ivTrial);
      print("Trial: $decryptedTrial");
      final iv = encrypt.IV.fromBase64(jsonMap["iv"]);
      final encrypter = encrypt.Encrypter(
          encrypt.AES(_key!, mode: encrypt.AESMode.cbc, padding: "PKCS7"));

      print(
          "Şifre çözme denemesi: IV=${jsonMap["iv"]}, Şifreli Değer=${jsonMap["value"]}");

      final decrypted = encrypter.decrypt64(jsonMap["value"], iv: iv);
      print("Başarıyla çözüldü: $decrypted");
      return decrypted;
    } catch (e) {
      print("Şifre çözme hatası: $e");
      print("Kullanılan anahtar: ${_key!.base64}");
      return null;
    }
  }

  static Future<void> saveEncryptedData(String key, String value) async {
    final encryptedValue = await encryptData(value);
    print("Şifrelenen veri: $encryptedValue");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, encryptedValue);
    print("Kaydedilen anahtar: $key");
  }

  static Future<String?> getEncryptedData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encryptedValue = prefs.getString(key);
    print("Alınan Veri: $encryptedValue");
    if (encryptedValue != null) {
      print("Şifre çözme denemesi için anahtar: $key");
      return decryptData(encryptedValue);
    }
    return null;
  }
}
