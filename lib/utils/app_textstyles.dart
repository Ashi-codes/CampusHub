import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {

  AppTextStyles._();

  static final welcome = GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: AppColors.title,
  );

  static final campusHub = GoogleFonts.poppins(
    fontSize: 54,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static final body = GoogleFonts.poppins(
    fontSize: 17,
    height: 1.7,
    color: AppColors.subtitle,
  );

  static final button = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

}