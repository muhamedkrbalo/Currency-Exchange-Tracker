import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radii.dart';
import 'app_typography.dart';
import 'extensions/app_color_ext.dart';
import 'extensions/app_spacing_ext.dart';


abstract final class AppTheme {
  const AppTheme._();

  static ThemeData light() => _build(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppPalette.seed,
          brightness: Brightness.light,
        ),
        appColors: AppColors.light,
      );

  static ThemeData dark() => _build(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppPalette.seed,
          brightness: Brightness.dark,
        ),
        appColors: AppColors.dark,
      );

  static ThemeData _build({
    required ColorScheme colorScheme,
    required AppColors appColors,
  }) {
    final textTheme = AppTypography.textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerHighest,
        shape:
            const RoundedRectangleBorder(borderRadius: AppRadii.radiusMd),
      ),
      chipTheme: ChipThemeData(
        shape:
            const RoundedRectangleBorder(borderRadius: AppRadii.radiusFull),
        backgroundColor: colorScheme.surfaceContainerHighest,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape:
              const RoundedRectangleBorder(borderRadius: AppRadii.radiusMd),
        ),
      ),
      extensions: <ThemeExtension<dynamic>>[
        appColors,
        AppSpacingExtension.standard,
      ],
    );
  }
}
