import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary = Color(0xFF4A90E2);
  static const secondary = Color(0xFF48D1CC);
  static const accent = Color(0xFFF5A623);
  static const lightBackground = Color(0xFFFFFFFF);
  static const lightSurface = Color(0xFFF7F9FA);
  static const lightTextPrimary = Color(0xFF2D3748);
  static const lightTextSecondary = Color(0xFF718096);
  static const darkBackground = Color(0xFF1A202C);
  static const darkSurface = Color(0xFF2D3748);
  static const darkTextPrimary = Color(0xFFE2E8F0);
  static const darkTextSecondary = Color(0xFFA0AEC0);
}

abstract final class AppTheme {
  static ThemeData lightTheme = _theme(Brightness.light);
  static ThemeData darkTheme = _theme(Brightness.dark);

  static ThemeData _theme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: isDark ? AppColors.darkSurface : AppColors.lightSurface,
    );
    final text = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final muted = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      fontFamily: 'NunitoSans',
      textTheme: ThemeData(brightness: brightness).textTheme
          .apply(bodyColor: text, displayColor: text)
          .copyWith(
            headlineSmall: TextStyle(
              color: text,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            titleLarge: TextStyle(
              color: text,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            bodyLarge: TextStyle(color: text, fontSize: 16, height: 1.45),
            bodyMedium: TextStyle(color: muted, fontSize: 14, height: 1.4),
          ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.darkSurface : Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: muted.withValues(alpha: .35)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: muted.withValues(alpha: .35)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
