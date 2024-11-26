import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';

class CustomTextThemes {
  // 검정색 텍스트
  static const TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'NotoSansKR',
      fontSize: Sizes.size56,
      fontVariations: [
        FontVariation('wght', 700), // Bold weight
      ],
      color: Colors.black87,
      decoration: TextDecoration.none,
    ),
    displayMedium: TextStyle(
      fontFamily: 'NotoSansKR',
      fontSize: Sizes.size44,
      fontVariations: [
        FontVariation('wght', 600), // Semi-bold weight
      ],
      color: Colors.black87,
      decoration: TextDecoration.none,
    ),
    displaySmall: TextStyle(
      fontFamily: 'NotoSansKR',
      fontSize: Sizes.size36,
      fontVariations: [
        FontVariation('wght', 500), // Medium weight
      ],
      color: Colors.black87,
      decoration: TextDecoration.none,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'NotoSansKR',
      fontSize: Sizes.size32,
      fontVariations: [
        FontVariation('wght', 700), // Bold weight
      ],
      color: Colors.black87,
      decoration: TextDecoration.none,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'NotoSansKR',
      fontSize: Sizes.size28,
      fontVariations: [
        FontVariation('wght', 600), // Semi-bold weight
      ],
      color: Colors.black87,
      decoration: TextDecoration.none,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'NotoSansKR',
      fontSize: Sizes.size24,
      fontVariations: [
        FontVariation('wght', 500), // Medium weight
      ],
      color: Colors.black87,
      decoration: TextDecoration.none,
    ),
    titleLarge: TextStyle(
      fontFamily: 'NotoSansKR',
      fontSize: Sizes.size20,
      fontVariations: [
        FontVariation('wght', 700), // Bold weight
      ],
      color: Colors.black87,
      decoration: TextDecoration.none,
    ),
    titleMedium: TextStyle(
      fontFamily: 'NotoSansKR',
      fontSize: Sizes.size18,
      fontVariations: [
        FontVariation('wght', 600), // Semi-bold weight
      ],
      color: Colors.black87,
      decoration: TextDecoration.none,
    ),
    titleSmall: TextStyle(
      fontFamily: 'NotoSansKR',
      fontSize: Sizes.size14,
      fontVariations: [
        FontVariation('wght', 500), // Medium weight
      ],
      color: Colors.black87,
      decoration: TextDecoration.none,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'NotoSansKR',
      fontSize: Sizes.size16,
      fontVariations: [
        FontVariation('wght', 400), // Regular weight
      ],
      color: Colors.black87,
      decoration: TextDecoration.none,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'NotoSansKR',
      fontSize: 15,
      fontVariations: [
        FontVariation('wght', 400), // Regular weight
      ],
      color: Colors.black87,
      decoration: TextDecoration.none,
    ),
    bodySmall: TextStyle(
      fontFamily: 'NotoSansKR',
      fontSize: Sizes.size12,
      fontVariations: [
        FontVariation('wght', 400), // Regular weight
      ],
      color: Colors.black54,
      decoration: TextDecoration.none,
    ),
    labelLarge: TextStyle(
      fontFamily: 'NotoSansKR',
      fontSize: Sizes.size14,
      fontVariations: [
        FontVariation('wght', 700), // Bold weight
      ],
      color: Colors.black87,
      decoration: TextDecoration.none,
    ),
    labelMedium: TextStyle(
      fontFamily: 'NotoSansKR',
      fontSize: Sizes.size12,
      fontVariations: [
        FontVariation('wght', 600), // Semi-bold weight
      ],
      color: Colors.black87,
      decoration: TextDecoration.none,
    ),
    labelSmall: TextStyle(
      fontFamily: 'NotoSansKR',
      fontSize: Sizes.size10,
      fontVariations: [
        FontVariation('wght', 500), // Medium weight
      ],
      color: Colors.black87,
      decoration: TextDecoration.none,
    ),
  );

  // 흰색 텍스트
  static TextTheme whiteTextTheme = TextTheme(
    displayLarge: darkTextTheme.displayLarge?.copyWith(
      color: Colors.white,
    ),
    displayMedium: darkTextTheme.displayMedium?.copyWith(
      color: Colors.white,
    ),
    displaySmall: darkTextTheme.displaySmall?.copyWith(
      color: Colors.white,
    ),
    headlineLarge: darkTextTheme.headlineLarge?.copyWith(
      color: Colors.white,
    ),
    headlineMedium: darkTextTheme.headlineMedium?.copyWith(
      color: Colors.white,
    ),
    headlineSmall: darkTextTheme.headlineSmall?.copyWith(
      color: Colors.white,
    ),
    titleLarge: darkTextTheme.titleLarge?.copyWith(
      color: Colors.white,
    ),
    titleMedium: darkTextTheme.titleMedium?.copyWith(
      color: Colors.white,
    ),
    titleSmall: darkTextTheme.titleSmall?.copyWith(
      color: Colors.white,
    ),
    bodyLarge: darkTextTheme.bodyLarge?.copyWith(
      color: Colors.white,
    ),
    bodyMedium: darkTextTheme.bodyMedium?.copyWith(
      color: Colors.white,
    ),
    bodySmall: darkTextTheme.bodySmall?.copyWith(
      color: Colors.white,
    ),
    labelLarge: darkTextTheme.labelLarge?.copyWith(
      color: Colors.white,
    ),
    labelMedium: darkTextTheme.labelMedium?.copyWith(
      color: Colors.white,
    ),
    labelSmall: darkTextTheme.labelSmall?.copyWith(
      color: Colors.white,
    ),
  );
}
