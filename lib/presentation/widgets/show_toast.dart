// ignore_for_file: constant_identifier_names

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:steps_counter/core/utils/app_colors.dart';

class ToastService {
  static void showCustomSnakeBar({
    required BuildContext context,
    required String msg,
    required bool isSuccess,
    FlushbarPosition? flushbarPosition,
  }) {
    Flushbar(
      message: msg,
      messageColor:
          isSuccess ? AppColors.kPrimaryColor : AppColors.destructiveD400Color,
      titleColor:
          isSuccess ? AppColors.kPrimaryColor : AppColors.destructiveD400Color,
      icon: isSuccess
          ? const Icon(
              Icons.check,
              size: 28.0,
              color: AppColors.kGreenColor,
            )
          : const Icon(
              Icons.warning_rounded,
              size: 28.0,
              color: AppColors.kErrorColor,
            ),
      flushbarPosition: flushbarPosition ?? FlushbarPosition.TOP,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(10),
      borderColor: isSuccess ? AppColors.kGreenColor : AppColors.kErrorColor,
      duration: const Duration(seconds: 3),
      progressIndicatorBackgroundColor: isSuccess
          ? AppColors.kPrimaryColor
          : AppColors.kErrorColor.withOpacity(.50),
      backgroundColor: isSuccess
          ? AppColors.secondary50Color
          : AppColors.backgroundLightRedColor,
    ).show(context);
  }
}

enum ToastStates { SUCCESS, ERROR, WARNING }

enum DropDownStates { CITY, COUNTRY, REGION, nationality }

//================chooseToastColor===============================================

Color? color;

Color? chooseToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      color = AppColors.kPrimaryColor;
      break;
    case ToastStates.ERROR:
      color = AppColors.kErrorColor;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
