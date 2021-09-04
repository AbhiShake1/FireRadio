import 'package:fire_radio/util/app_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static ThemeData light(BuildContext context) {
    return dark(context); // same for now. can be implemented later
    //return ThemeData();
  }

  static ThemeData dark(BuildContext context) {
    return ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      primaryColor: AppColors.primaryColor1,
      backgroundColor: AppColors.primaryColor1,
      focusColor: Colors.white,
      scaffoldBackgroundColor: Colors.black,
    );
  }
}
