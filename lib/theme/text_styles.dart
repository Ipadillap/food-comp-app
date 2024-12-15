import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  // ESTILO PARA LOS TÍTULOS
  static TextStyle title = GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 255, 255, 255),
    ),
  );

  // ESTILO PARA LOS SUBTÍTULOS
  static TextStyle subtitle = GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color.fromARGB(218, 255, 255, 255),
    ),
  );

  // ESTILO PARA LOS PÁRRAFOS
  static TextStyle paragraph = GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.black87,
    ),
  );

  // ESTILO PARA BOTONES
  static TextStyle button = GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}
