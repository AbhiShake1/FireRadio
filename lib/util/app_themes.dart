import 'package:fire_radio/util/app_util.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData light(BuildContext context) {
    return ThemeData();
  }

  static ThemeData dark(BuildContext context) {
    return ThemeData(
      primaryColor: AppColors.primaryColor1,
      backgroundColor: AppColors.primaryColor1,
    );
  }
}
