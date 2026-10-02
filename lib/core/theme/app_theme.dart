import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bgMain,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.ringGold,
        surface: AppColors.bgSurface,
        onPrimary: AppColors.bgMain,
        onSurface: AppColors.textPrimary,
        secondary: AppColors.ringGold,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bgMain,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.ringGold),
        titleTextStyle: GoogleFonts.cinzel(
          color: AppColors.ringGold,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 3,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.bgSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.bgSurface,
        hintStyle: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.7)),
        prefixIconColor: AppColors.ringGold,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.ringGold, width: 1.5),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.cinzel(
          color: AppColors.ringGold,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: 3,
        ),
        titleLarge: GoogleFonts.cinzel(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: GoogleFonts.cinzel(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.lato(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
        bodyMedium: GoogleFonts.lato(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
      ),
    );
  }
}
