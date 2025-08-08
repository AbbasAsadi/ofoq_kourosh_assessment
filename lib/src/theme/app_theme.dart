import 'package:flutter/material.dart';
import 'package:ofoq_kourosh_assessment/gen/fonts.gen.dart';
import 'package:ofoq_kourosh_assessment/src/theme/app_colors.dart';

mixin AppTheme {
  static InputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(width: 1, color: AppColors.border),
  );

  static ThemeData get mainTheme => ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    textTheme: defaultTextTheme,
    inputDecorationTheme: InputDecorationTheme(
      border: inputBorder,
      disabledBorder: inputBorder,
      enabledBorder: inputBorder,
      focusedBorder: inputBorder,
      filled: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      hintStyle: defaultTextTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w400,
        color: Colors.white.withValues(alpha: 0.5),
      ),
    ),
  );

  static String fontFamily() => FontFamily.estedad;

  static const double fontHeightSpacing = 1.6;

  static final TextTheme defaultTextTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: fontFamily(),
      height: fontHeightSpacing,
      color: AppColors.black,
    ),
    headlineMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: fontFamily(),
      height: fontHeightSpacing,
      color: AppColors.black,
    ),
    headlineSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      fontFamily: fontFamily(),
      height: fontHeightSpacing,
      color: AppColors.black,
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily(),
      height: fontHeightSpacing,
      color: AppColors.black,
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily(),
      height: fontHeightSpacing,
      color: AppColors.black,
    ),
    titleSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily(),
      height: fontHeightSpacing,
      color: AppColors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily(),
      height: fontHeightSpacing,
      color: AppColors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily(),
      height: fontHeightSpacing,
      color: AppColors.black,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily(),
      height: fontHeightSpacing,
      color: AppColors.black,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily(),
      height: fontHeightSpacing,
      color: AppColors.black,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily(),
      height: fontHeightSpacing,
      color: AppColors.black,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily(),
      height: fontHeightSpacing,
      color: AppColors.black,
    ),
  );
}
