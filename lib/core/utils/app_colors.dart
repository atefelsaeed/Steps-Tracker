import 'package:flutter/material.dart';

class AppColors {
  static const kBlackColor = Color(0xFF000000);
  static const kScaffoldBackgroundColor = Color(0xFFFFFFFF);
  static Color kPrimaryColor =HexColor.fromHex('#152948');
  static const kErrorColor = Colors.red;
  static const kRedAccentColor = Colors.redAccent;
  static const kGreyColor = Colors.grey;
  static const kGreenColor = Colors.green;
  static Color destructiveD400Color = HexColor.fromHex('#9A2222');
  static Color backgroundLightRedColor = HexColor.fromHex('#FEF3F2');
  static Color secondary50Color = HexColor.fromHex('#F3F9EF');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString'; // 8 char with 100% opacity
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
