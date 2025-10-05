import 'package:ecommerce/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.black,
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.readexProTextTheme().apply(),
  );
}
