import "dart:convert";

import "package:flutter/services.dart";

class Config {
  static late final Map<String, dynamic> _config;
  static late final String _apiSecret;

  // this function is to be called once at the start of the program and then not
  // again
  static Future<void> loadConfig(String path) async {
    final configContent = await rootBundle.loadString(path);
    _config = jsonDecode(configContent) as Map<String, dynamic>;

    _apiSecret = await rootBundle.loadString("assets/api_secret.json");
  }

  static String getSheetId() {
    return _config["sheet_id"] as String;
  }

  static String getApiSecret() {
    return _apiSecret;
  }
}
