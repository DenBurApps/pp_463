import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyles {
  static TextStyle displayLarge(Color color) {
    return GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle displaySmall(Color color) {
    return GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle bodyLarge(Color color) {
    return GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle bodyMedium(Color color) {
    return GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle bodySmall(Color color) {
    return GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

}
