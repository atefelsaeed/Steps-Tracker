import 'package:flutter/cupertino.dart';

enum AppLanguageModel {
  english(Locale('en')),
  arabic(Locale('ar'));

  const AppLanguageModel(this.value);

  final Locale value;
}
