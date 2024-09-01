import 'dart:io';

import 'package:flutter/material.dart';

class BottomSheetHelper {
  static Future<dynamic> showBottomSheet(
    BuildContext context, {
    AnimationController? transitionAnimationController,
    double? height,
    Color? backgroundColor,
    bool? isExpanded,
    Widget? child,
  }) =>
      showModalBottomSheet(
        isScrollControlled: true,
        transitionAnimationController: transitionAnimationController,
        backgroundColor: Colors.transparent,
        barrierColor: const Color(0xFF4B4743).withOpacity(0.4),
        elevation: 0,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => Container(
          padding: Platform.isAndroid
              ? EdgeInsets.zero
              : const EdgeInsets.only(bottom: 15),
          constraints:
              height != null ? BoxConstraints(maxHeight: height) : null,
          decoration: const BoxDecoration(
            // color: backgroundColor ?? AppColors.whiteColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 18),
              Container(
                // height: 5.h,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 8),
              if (child != null && isExpanded == true)
                Flexible(child: child)
              else
                child ?? const SizedBox.shrink()
            ],
          ),
        ),
      );
}
