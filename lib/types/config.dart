import "dart:convert";

import "package:encrypt/encrypt.dart";
import "package:flutter/services.dart";

class Config {
  static late final Map<String, dynamic> _config;
  static late final String _apiSecret;

  static Future<String?> _readFile(String path) async {
    try {
      return await rootBundle.loadString(path);
    } catch (_) {
      return null;
    }
  }

  /// This function is to be called once at the start of the program and then
  /// not again
  static Future<bool> loadConfig(String path) async {
    final configContent = await _readFile(path);
    if (configContent == null) return false;
    _config = jsonDecode(configContent) as Map<String, dynamic>;

    final apiSecret = await _readFile("assets/api_secret.json");
    if (apiSecret == null) return false;
    _apiSecret = apiSecret;
    return true;
  }

  static String getSheetId() {
    return _config["sheet_id"] as String;
  }

  static String getApiSecret() {
    return _apiSecret;
  }

  static Key getAesKey() {
    return Key.fromBase64(_config["aes_key"] as String);
  }
}
