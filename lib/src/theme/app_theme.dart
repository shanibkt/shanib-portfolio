import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color background = Color(0xFF0B0F19);
  static const Color secondary = Color(0xFF111827);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFA0AEC0);
  
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: Colors.blueAccent,
      colorScheme: const ColorScheme.dark(
        primary: Colors.blueAccent,
        secondary: Colors.indigoAccent,
        surface: secondary,
        background: background,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.spaceGrotesk(
          textStyle: const TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
        ),
        displayMedium: GoogleFonts.spaceGrotesk(
          textStyle: const TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
        ),
        displaySmall: GoogleFonts.spaceGrotesk(
          textStyle: const TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
        ),
        headlineMedium: GoogleFonts.spaceGrotesk(
          textStyle: const TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
        ),
        titleLarge: GoogleFonts.spaceGrotesk(
          textStyle: const TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
