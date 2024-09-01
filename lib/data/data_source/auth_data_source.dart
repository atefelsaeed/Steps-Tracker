import 'dart:convert';

import 'package:steps_counter/core/utils/key_constant.dart';
import 'package:steps_counter/data/data_source/data_storage.dart';
import 'package:steps_counter/data/models/user_model.dart';

class AuthLocalDataSource {
  Future<UserModel?> currentUser() async {
    final currentUserAsJSON = json
        .decode(await (DataStorage.readData(KeyConstants.currentUser)) ?? "");
    return UserModel.fromMap(
      currentUserAsJSON,
      currentUserAsJSON['uid'] ?? '',
    );
  }

  Future<void> persistAuth(UserModel user) async {
    final encodedJson = json.encode(user.toMap(forLocalStorage: true));
    await DataStorage.writeData(
      KeyConstants.currentUser,
      encodedJson,
    );
  }

  Future<void> clearAuth() async {
    await DataStorage.removeData(KeyConstants.currentUser);
  }
}
