import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steps_counter/core/routes/routes.dart';
import 'package:steps_counter/core/utils/app_assets.dart';
import 'package:steps_counter/domain/auth_service/auth_service.dart';
import 'package:steps_counter/domain/firebase_service/auth_state_enums.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Check auth state and navigate after a delay.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _checkAuthenticationAndNavigate();
    });
  }

  Future<void> _checkAuthenticationAndNavigate() async {
    // Add a delay for the splash screen animation/effect.
    await Future.delayed(const Duration(seconds: 2));

    // Get the AuthServiceNotifier instance.
    final authService = ref.read(authServiceProvider.notifier);

    // Check the user's authentication status.
    final isAuthenticated = await authService.checkAuthStatus();

    // Navigate based on the authentication status.
    if (isAuthenticated == AuthState.authenticated) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.indexPageRoute);
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.loginPageRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.manInBackgroundIntro),
          fit: BoxFit.cover,
        ),
      ),
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Opacity(
          opacity: 0.7,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
