import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:calculator_app/models/calculation_history.dart';

/// Service for persisting app data
class StorageService {
  static const String _historyKey = 'calculation_history';
  static const String _themeKey = 'theme_mode';
  static const String _memoryKey = 'memory_value';

  /// Saves calculation history to local storage
  static Future<void> saveHistory(List<CalculationEntry> entries) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = entries.map((entry) => entry.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await prefs.setString(_historyKey, jsonString);
    } catch (e) {
      // Handle error silently or log it
    }
  }

  /// Loads calculation history from local storage
  static Future<List<CalculationEntry>> loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_historyKey);

      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final jsonList = jsonDecode(jsonString) as List;
      return jsonList
          .map(
              (json) => CalculationEntry.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Clears calculation history
  static Future<void> clearHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_historyKey);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Saves theme mode
  static Future<void> saveThemeMode(String mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, mode);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Loads theme mode
  static Future<String?> loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_themeKey);
    } catch (e) {
      return null;
    }
  }

  /// Saves memory value
  static Future<void> saveMemory(double value, bool hasValue) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_memoryKey, value);
      await prefs.setBool('${_memoryKey}_has_value', hasValue);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Loads memory value
  static Future<Map<String, dynamic>> loadMemory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final value = prefs.getDouble(_memoryKey) ?? 0.0;
      final hasValue = prefs.getBool('${_memoryKey}_has_value') ?? false;
      return {'value': value, 'hasValue': hasValue};
    } catch (e) {
      return {'value': 0.0, 'hasValue': false};
    }
  }
}
