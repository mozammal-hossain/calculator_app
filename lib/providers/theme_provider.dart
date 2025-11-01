import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator_app/services/storage_service.dart';

/// Provider for theme mode management
final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

/// StateNotifier for managing theme mode
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  /// Loads theme mode from storage
  Future<void> _loadThemeMode() async {
    final savedMode = await StorageService.loadThemeMode();
    if (savedMode != null) {
      state = _themeModeFromString(savedMode);
    }
  }

  /// Sets the theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await StorageService.saveThemeMode(_themeModeToString(mode));
  }

  /// Toggles between light and dark mode
  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await setThemeMode(newMode);
  }

  /// Converts ThemeMode to String
  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  /// Converts String to ThemeMode
  ThemeMode _themeModeFromString(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }
}
