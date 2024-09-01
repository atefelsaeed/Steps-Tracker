import 'package:flutter/material.dart';
import 'package:steps_counter/core/utils/app_colors.dart';

class MainTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      primaryColor: AppColors.kPrimaryColor,
      scaffoldBackgroundColor: AppColors.kScaffoldBackgroundColor,
      primaryColorDark: AppColors.kGreyColor,
      primaryColorLight: AppColors.kPrimaryColor,
      dividerTheme: DividerThemeData(
        color: AppColors.kGreyColor.withOpacity(0.4),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.kScaffoldBackgroundColor,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.kPrimaryColor,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: AppColors.kScaffoldBackgroundColor,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColors.kScaffoldBackgroundColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.0),
            borderSide: BorderSide(
              color: AppColors.kPrimaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.0),
            borderSide: BorderSide(
              color: AppColors.kPrimaryColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.0),
            borderSide: const BorderSide(
              color: AppColors.kErrorColor,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.0),
            borderSide: const BorderSide(
              color: AppColors.kErrorColor,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.0),
            borderSide: BorderSide(
              color: AppColors.kPrimaryColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.0),
            borderSide: BorderSide(
              color: AppColors.kPrimaryColor,
            ),
          ),
          errorStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          )),
      canvasColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        background: AppColors.kRedAccentColor,
        error: AppColors.kErrorColor,
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      primaryColor: AppColors.kScaffoldBackgroundColor,
      scaffoldBackgroundColor: AppColors.kPrimaryColor,
      primaryColorLight: AppColors.kPrimaryColor,
      primaryColorDark: AppColors.kScaffoldBackgroundColor,
      dividerTheme: DividerThemeData(
        color: AppColors.kScaffoldBackgroundColor.withOpacity(0.4),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.kBlackColor,
      ),
      listTileTheme: const ListTileThemeData(
        textColor: AppColors.kScaffoldBackgroundColor,
      ),
      cardColor: Colors.grey,
      appBarTheme:  AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.kScaffoldBackgroundColor,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.kPrimaryColor,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.kScaffoldBackgroundColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: BorderSide(
            color: AppColors.kPrimaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: BorderSide(
            color: AppColors.kPrimaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: const BorderSide(
            color: AppColors.kErrorColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: const BorderSide(
            color: AppColors.kErrorColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: BorderSide(
            color: AppColors.kPrimaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: BorderSide(
            color: AppColors.kPrimaryColor,
          ),
        ),
        errorStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      canvasColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        background: AppColors.kRedAccentColor,
        error: AppColors.kErrorColor,
      ),
    );
  }
}
