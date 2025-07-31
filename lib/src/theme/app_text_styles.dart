import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle title(double alto) {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: alto * 0.045,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  static TextStyle subTitle(double alto) {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: alto * 0.03,
        fontWeight: FontWeight.w600,
        color: Colors.white.withOpacity(0.85),
      ),
    );
  }

  static TextStyle body(double alto, {Color? color}) {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: alto * 0.021,
        fontWeight: FontWeight.normal,
        color: const Color(0xFF222222),
      ),
    );
  }
}