import 'package:flutter/material.dart';


abstract final class AppTypography {
  const AppTypography._();

  static const TextStyle displayLarge =
      TextStyle(fontSize: 32, fontWeight: FontWeight.w700, height: 1.2);
  static const TextStyle headlineMedium =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w600, height: 1.25);
  static const TextStyle titleLarge =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600, height: 1.3);
  static const TextStyle titleMedium =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600, height: 1.3);
  static const TextStyle bodyLarge =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.4);
  static const TextStyle bodyMedium =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.4);
  static const TextStyle labelSmall =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 1.3);

  static const TextTheme textTheme = TextTheme(
    displayLarge: displayLarge,
    headlineMedium: headlineMedium,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    labelSmall: labelSmall,
  );
}
