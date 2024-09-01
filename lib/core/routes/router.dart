import 'package:flutter/cupertino.dart';
import 'package:steps_counter/core/routes/routes.dart';
import 'package:steps_counter/presentation/screens/index/index_secreen.dart';
import 'package:steps_counter/presentation/screens/login_screen/login_screen.dart';
import 'package:steps_counter/presentation/screens/profile_screen/profile_screen.dart';
import 'package:steps_counter/presentation/screens/splash_screen/splash_screen.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splashPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const SplashScreen(),
        settings: settings,
      );
    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(
        builder: (_) => LoginScreen(),
        settings: settings,
      );
    case AppRoutes.indexPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const BottomNavbar(),
        settings: settings,
      );
    case AppRoutes.userProfileScreen:
      return CupertinoPageRoute(
        builder: (_) => const UserProfileScreen(),
        settings: settings,
      );

    default:
      return CupertinoPageRoute(
        builder: (_) => const SplashScreen(),
        settings: settings,
      );
  }
}
