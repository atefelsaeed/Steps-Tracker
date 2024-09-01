import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:steps_counter/domain/steps_service/steps_service.dart';

class StepsBackgroundService {
 static Future<void> initializeService() async {

    final service = FlutterBackgroundService();

    await service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onServiceStart,
        onBackground: onIosBackground,
      ),
      androidConfiguration: AndroidConfiguration(
        autoStart: true,
        onStart: onServiceStart,
        isForegroundMode: false,
        autoStartOnBoot: true,
      ),
    );
  }

 static void onServiceStart(ServiceInstance service) async {
    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }

    service.on('stopService').listen((event) {
      service.stopSelf();
    });
    // Initialize your step counter and other background logic here
    StepCounterBackgroundService().startTracking();
  }

  static void stopBackgroundService() {
    final service = FlutterBackgroundService();
    service.invoke("stop");
  }
}

Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  // Initialize your step counter and other background logic here
  StepCounterBackgroundService().startTracking();
  return true;
}
