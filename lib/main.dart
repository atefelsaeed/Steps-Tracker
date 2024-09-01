import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steps_counter/core/app_localization/app_localization_provider.dart';
import 'package:steps_counter/core/app_localization/app_localization_setup.dart';
import 'package:steps_counter/core/app_theme/app_theme.dart';
import 'package:steps_counter/core/app_theme/app_theme_enum.dart';
import 'package:steps_counter/core/app_theme/app_theme_provider.dart';
import 'package:steps_counter/core/routes/router.dart';
import 'package:steps_counter/core/routes/routes.dart';
import 'package:steps_counter/domain/background_service/background_service.dart';
import 'package:steps_counter/domain/firebase_service/friebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StepsBackgroundService.initializeService();
  await FirebaseService.initialize();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final langState = ref.watch(languageProvider);
    final themeMode = ref.watch(themeProvider);

    return ProviderScope(
      child: GestureDetector(
        onTap: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          title: 'Steps Tracker',
          debugShowCheckedModeBanner: false,
          theme: MainTheme.lightTheme(context),
          darkTheme: MainTheme.darkTheme(context),
          themeMode: themeMode == AppThemeMode.light
              ? ThemeMode.light
              : ThemeMode.dark,
          locale: langState.value,
          supportedLocales: AppLocalizationsSetup.supportedLocales,
          localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
          onGenerateRoute: onGenerate,
          initialRoute: AppRoutes.splashPageRoute,
        ),
      ),
    );
  }
}
