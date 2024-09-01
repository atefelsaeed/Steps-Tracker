import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_counter/core/app_theme/app_theme_enum.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<AppThemeMode> {
  ThemeNotifier() : super(AppThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme') ?? 'light';
    if (theme == 'dark') {
      state = AppThemeMode.dark;
    } else {
      state = AppThemeMode.light;
    }
  }

  Future<void> toggleTheme() async {
    if (state == AppThemeMode.light) {
      state = AppThemeMode.dark;
      await _saveTheme('dark');
    } else {
      state = AppThemeMode.light;
      await _saveTheme('light');
    }
  }

  Future<void> _saveTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);
  }
}
