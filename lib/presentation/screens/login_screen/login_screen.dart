import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steps_counter/core/routes/routes.dart';
import 'package:steps_counter/core/utils/app_assets.dart';
import 'package:steps_counter/core/utils/app_colors.dart';
import 'package:steps_counter/domain/auth_service/auth_service.dart';
import 'package:steps_counter/domain/firebase_service/auth_state_enums.dart';
import 'package:steps_counter/generated/l10n.dart';
import 'package:steps_counter/presentation/widgets/default_text_form_field.dart';
import 'package:steps_counter/presentation/widgets/show_toast.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final weightController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.read(authServiceProvider.notifier);

    final state = ref.watch(authServiceProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.manInBackgroundIntro),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            SizedBox(
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
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 60.0),
                      Image.asset(
                        AppAssets.logo,
                        fit: BoxFit.cover,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        height: 180,
                      ),
                      Text(
                        S.of(context).all_in_one_track,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                      ),
                      const SizedBox(height: 40.0),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            DefaultTextFormField(
                              controller: nameController,
                              errorMsg: S.of(context).enter_your_name,
                              hintText: S.of(context).enter_your_name,
                            ),
                            const SizedBox(height: 16.0),
                            DefaultTextFormField(
                              controller: weightController,
                              errorMsg: S.of(context).enter_your_weight,
                              hintText: S.of(context).enter_your_weight,
                              inputAction: TextInputAction.done,
                              inputType: TextInputType.number,
                            ),
                            const SizedBox(height: 24.0),
                            InkWell(
                              onTap: () async {
                                String username = nameController.text.trim();
                                double weight = double.tryParse(
                                        weightController.text.trim()) ??
                                    0;

                                if (formKey.currentState!.validate()) {
                                  if (username.isNotEmpty && weight > 0.0) {
                                    User? user =
                                        await authService.signInAnonymously(
                                      username: username,
                                      weight: weight,
                                    );
                                    if (user != null) {
                                      debugPrint(
                                          "Signed in anonymously as: ${user.uid}");
                                      //Starting the background service.
                                      FlutterBackgroundService().startService();
                                      ToastService.showCustomSnakeBar(
                                        context: context,
                                        msg: S.current.login_success,
                                        isSuccess: true,
                                      );
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              AppRoutes.indexPageRoute);
                                    } else {
                                      ToastService.showCustomSnakeBar(
                                        context: context,
                                        msg: S.current.login_failed,
                                        isSuccess: false,
                                      );
                                    }
                                  } else {
                                    ToastService.showCustomSnakeBar(
                                      context: context,
                                      msg: S.current.enter_valid_weight,
                                      isSuccess: false,
                                    );
                                  }
                                }
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                child: Center(
                                  child: state != AuthState.loading
                                      ? Text(
                                          S.of(context).start_using_steps,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        )
                                      : const CircularProgressIndicator(
                                          color: AppColors.kGreenColor,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
