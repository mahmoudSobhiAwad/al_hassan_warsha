import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPreferences? _prefs;

  /// Initialize SharedPreferences
  static Future<void> initShared() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save multiple folder paths
  static Future<void> saveFolderPath(Map<String, String> data) async {
    if (_prefs == null) {
      throw Exception("SharedPreferences not initialized. Call initShared() first.");
    }

    for (var entry in data.entries) {
      await _prefs!.setString(entry.key, entry.value);
    }
  }

  /// Fetch a folder path by key
  static String? fetchPathFromShared(String key) {
    if (_prefs == null) {
      throw Exception("SharedPreferences not initialized. Call initShared() first.");
    }
    return _prefs!.getString(key);
  }
}
