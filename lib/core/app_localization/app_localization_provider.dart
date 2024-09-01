import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steps_counter/core/app_localization/app_language_enum.dart';
import 'package:steps_counter/core/utils/key_constant.dart';
import 'package:steps_counter/data/data_source/data_storage.dart';

class LanguageNotifier extends StateNotifier<AppLanguageModel> {
  LanguageNotifier() : super(AppLanguageModel.english) {
    _getLanguage();
  }

  Future<void> changeLanguage(AppLanguageModel selectedLanguage) async {
    await DataStorage.writeData(
        KeyConstants.localeKey, selectedLanguage.value.languageCode);
    state = selectedLanguage;
  }

  Future<void> _getLanguage() async {
    final selectedLanguage = await DataStorage.readData(KeyConstants.localeKey);
    if (selectedLanguage == null) {
      await DataStorage.writeData(
          KeyConstants.localeKey, AppLanguageModel.arabic.value.languageCode);
      state = AppLanguageModel.arabic;
    } else {
      state = AppLanguageModel.values.firstWhere(
        (item) => item.value.languageCode == selectedLanguage,
        orElse: () => AppLanguageModel.english,
      );
    }
  }
}

final languageProvider =
    StateNotifierProvider<LanguageNotifier, AppLanguageModel>((ref) {
  return LanguageNotifier();
});
