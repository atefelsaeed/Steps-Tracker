// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Everything you need to track your activity!`
  String get all_in_one_track {
    return Intl.message(
      'Everything you need to track your activity!',
      name: 'all_in_one_track',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get enter_your_name {
    return Intl.message(
      'Please enter your name',
      name: 'enter_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your weight`
  String get enter_your_weight {
    return Intl.message(
      'Please enter your weight',
      name: 'enter_your_weight',
      desc: '',
      args: [],
    );
  }

  /// `Start using`
  String get start_using_steps {
    return Intl.message(
      'Start using',
      name: 'start_using_steps',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong!`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong!',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `No data available!`
  String get empty_state {
    return Intl.message(
      'No data available!',
      name: 'empty_state',
      desc: '',
      args: [],
    );
  }

  /// `Pedometer`
  String get pedometer {
    return Intl.message(
      'Pedometer',
      name: 'pedometer',
      desc: '',
      args: [],
    );
  }

  /// `Today's Steps`
  String get total_steps_today {
    return Intl.message(
      'Today\'s Steps',
      name: 'total_steps_today',
      desc: '',
      args: [],
    );
  }

  /// `Steps History`
  String get steps_history {
    return Intl.message(
      'Steps History',
      name: 'steps_history',
      desc: '',
      args: [],
    );
  }

  /// `Weight History`
  String get weight_history {
    return Intl.message(
      'Weight History',
      name: 'weight_history',
      desc: '',
      args: [],
    );
  }

  /// `Steps Counter`
  String get steps_counter {
    return Intl.message(
      'Steps Counter',
      name: 'steps_counter',
      desc: '',
      args: [],
    );
  }

  /// `Logged in successfully`
  String get login_success {
    return Intl.message(
      'Logged in successfully',
      name: 'login_success',
      desc: '',
      args: [],
    );
  }

  /// `Login failed`
  String get login_failed {
    return Intl.message(
      'Login failed',
      name: 'login_failed',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Logout`
  String get confirm_logout {
    return Intl.message(
      'Confirm Logout',
      name: 'confirm_logout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get want_logout {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'want_logout',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Steps`
  String get steps_list {
    return Intl.message(
      'Steps',
      name: 'steps_list',
      desc: '',
      args: [],
    );
  }

  /// `Weights`
  String get weight_list {
    return Intl.message(
      'Weights',
      name: 'weight_list',
      desc: '',
      args: [],
    );
  }

  /// `weight`
  String get weight {
    return Intl.message(
      'weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `kg`
  String get kg {
    return Intl.message(
      'kg',
      name: 'kg',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid weight.`
  String get enter_valid_weight {
    return Intl.message(
      'Please enter valid weight.',
      name: 'enter_valid_weight',
      desc: '',
      args: [],
    );
  }

  /// `Current Steps`
  String get current_steps {
    return Intl.message(
      'Current Steps',
      name: 'current_steps',
      desc: '',
      args: [],
    );
  }

  /// `Steps Tracker`
  String get steps_tracker {
    return Intl.message(
      'Steps Tracker',
      name: 'steps_tracker',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Change Theme`
  String get change_theme {
    return Intl.message(
      'Change Theme',
      name: 'change_theme',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `User Profile`
  String get user_profile {
    return Intl.message(
      'User Profile',
      name: 'user_profile',
      desc: '',
      args: [],
    );
  }

  /// `Update Weight`
  String get update_weight {
    return Intl.message(
      'Update Weight',
      name: 'update_weight',
      desc: '',
      args: [],
    );
  }

  /// `Profile image updated successfully!`
  String get profile_image_uploaded_successfully {
    return Intl.message(
      'Profile image updated successfully!',
      name: 'profile_image_uploaded_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Weight updated successfully!`
  String get weight_uploaded_successfully {
    return Intl.message(
      'Weight updated successfully!',
      name: 'weight_uploaded_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Error updated Profile image!`
  String get profile_image_uploaded_error {
    return Intl.message(
      'Error updated Profile image!',
      name: 'profile_image_uploaded_error',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
