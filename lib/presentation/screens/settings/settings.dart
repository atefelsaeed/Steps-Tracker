import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steps_counter/core/app_localization/app_language_enum.dart';
import 'package:steps_counter/core/app_localization/app_localization_provider.dart';
import 'package:steps_counter/core/app_theme/app_theme_provider.dart';
import 'package:steps_counter/core/routes/routes.dart';
import 'package:steps_counter/core/utils/app_colors.dart';
import 'package:steps_counter/domain/auth_service/auth_service.dart';
import 'package:steps_counter/generated/l10n.dart';
import 'package:steps_counter/presentation/screens/settings/item_setting.dart';
import 'package:steps_counter/presentation/widgets/show_toast.dart';

import '../../../core/app_theme/app_theme_enum.dart';

class AppSettings extends ConsumerWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.read(themeProvider.notifier);
    final isDarkMode = ref.watch(themeProvider) == AppThemeMode.dark;
    final currentLanguage = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.settings),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ItemSetting(
                iconData: Icons.person,
                child: Text(
                  S.current.profile,
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
                callback: () {
                  Navigator.of(context).pushNamed(AppRoutes.userProfileScreen);
                },
              ),
              ItemSetting(
                iconData: isDarkMode ? Icons.light_mode : Icons.dark_mode,
                child: Text(
                  S.current.change_theme,
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
                callback: () => themeNotifier.toggleTheme(),
              ),
              ItemSetting(
                iconData: Icons.language,
                child: Text(
                  "${S.current.change_language} ${currentLanguage == AppLanguageModel.arabic ? "(English)" : "(العربية)"}",
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
                callback: () {
                  currentLanguage == AppLanguageModel.arabic
                      ? ref
                          .read(languageProvider.notifier)
                          .changeLanguage(AppLanguageModel.english)
                      : ref
                          .read(languageProvider.notifier)
                          .changeLanguage(AppLanguageModel.arabic);
                },
              ),
              const SizedBox(height: 10),
              const Divider(thickness: 2,),
              const SizedBox(height: 10),
              ItemSetting(
                iconData: Icons.exit_to_app,
                child: Text(
                  S.current.logout,
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
                callback: () async {
                  _showLogoutConfirmationDialog(context, ref);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissal by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(S.current.confirm_logout)),
          content: Text(S.current.want_logout),
          backgroundColor: AppColors.kScaffoldBackgroundColor,
          actions: [
            TextButton(
              onPressed: () async {
                final authService = ref.read(authServiceProvider.notifier);

                // Call the logout function
                ref.read(authServiceProvider.notifier).signOut();

                await authService.signOut();

                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.loginPageRoute,
                  (Route<dynamic> route) => false,
                );

                ToastService.showCustomSnakeBar(
                  context: context,
                  msg: S.current.login_success,
                  isSuccess: true,
                );
              },
              child: Text(S.current.logout),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(S.current.cancel),
            ),
          ],
        );
      },
    );
  }
}
