import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FirebaseService {
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
      await requestActivityRecognitionPermission();
    } catch (ex, trc) {
      debugPrint("Error: $ex  @@ Trace: $trc");
    }
  }

  static Future<void> requestActivityRecognitionPermission() async {
    if (await Permission.activityRecognition.isDenied) {
      await Permission.activityRecognition.request();
    }
  }
}
