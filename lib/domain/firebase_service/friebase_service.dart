import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class FirebaseService {
  static Future<void> initialize() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
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

  final stepsListProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
    return FirebaseFirestore.instance
        .collection('steps')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  });

  final weightListProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
    return FirebaseFirestore.instance
        .collection('weights')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  });
}
