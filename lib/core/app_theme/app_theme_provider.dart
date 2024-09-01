import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steps_counter/core/app_theme/app_theme_enum.dart';
import 'package:steps_counter/core/utils/key_constant.dart';
import 'package:steps_counter/data/data_source/data_storage.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<AppThemeMode> {
  ThemeNotifier() : super(AppThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final theme = await DataStorage.readData(KeyConstants.theme) ?? 'light';
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
    await DataStorage.writeData(KeyConstants.theme, theme);
  }
}
