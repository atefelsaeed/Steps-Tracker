import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_counter/core/utils/key_constant.dart';
import 'package:steps_counter/domain/steps_service/steps_service.dart';

class StepsBackgroundService {
  void initializeService() {
    // FlutterBackgroundService.initialize(onStart);
  }

  // // Background service entry point
  // void onStart() {
  //   WidgetsFlutterBinding.ensureInitialized();
  //
  //   // Initializing the pedometer and firestore services
  //   StepCounterBackgroundService().startService();
  //
  //   FlutterBackgroundService().onDataReceived.listen((event) {
  //     if (event!["action"] == "stopService") {
  //       FlutterBackgroundService().stopBackgroundService();
  //     }
  //   });
  // }
}

// Background service entry point
void onStart() {
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();

  if (service is AndroidServiceInstance) {
    // service.onStart.listen((event) {
    //   // Bring the Flutter background service to life by updating state
    //   StepCounterBackgroundService().startTracking();
    // });
  }
}

// class StepCounterBackgroundService {
//   late StreamSubscription<StepCount> _subscription;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   DateTime? _lastResetDate;
//
//   void startService() {
//     _initPedometer();
//     _loadLastResetDate(); // Load the last reset date from storage
//   }
//
//   Future<void> _loadLastResetDate() async {
//     final prefs = await SharedPreferences.getInstance();
//     final lastResetTimestamp = prefs.getInt(KeyConstants.lastResetDate);
//
//     if (lastResetTimestamp != null) {
//       _lastResetDate = DateTime.fromMillisecondsSinceEpoch(lastResetTimestamp);
//     }
//
//     _checkAndResetSteps(); // Check if we need to reset steps at the start
//   }
//
//   void _initPedometer() {
//     _subscription = Pedometer.stepCountStream.listen(
//       _onStepCount,
//       onError: _onError,
//       onDone: _onDone,
//       cancelOnError: true,
//     );
//
//     debugPrint('Pedometer initialized and listening to step count stream.');
//   }
//
//   void _onStepCount(StepCount event) {
//     _checkAndResetSteps(); // Check if we need to reset steps
//
//     // Save the step count and timestamp to Firestore
//     _firestore.collection('steps').add({
//       'steps': event.steps,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//   }
//
//   void _checkAndResetSteps() async {
//     final now = DateTime.now();
//
//     // Check if the last reset date is not today
//     if (_lastResetDate == null || !_isSameDay(_lastResetDate!, now)) {
//       // Reset steps to 0
//       _lastResetDate = now;
//       final prefs = await SharedPreferences.getInstance();
//       prefs.setInt(KeyConstants.lastResetDate, now.millisecondsSinceEpoch);
//
//       debugPrint('Steps reset to 0 for a new day.');
//     }
//   }
//
//   bool _isSameDay(DateTime date1, DateTime date2) {
//     return date1.year == date2.year &&
//         date1.month == date2.month &&
//         date1.day == date2.day;
//   }
//
//   void _onError(error) {
//     debugPrint('Error in Pedometer: $error');
//   }
//
//   void _onDone() {
//     debugPrint('Pedometer stream closed.');
//   }
//
//   void dispose() {
//     // Cancel the subscription when disposing the notifier
//     _subscription.cancel();
//   }
// }
