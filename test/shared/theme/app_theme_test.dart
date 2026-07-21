import 'package:currency_exchange_tracker/shared/theme/extensions/app_color_ext.dart';
import 'package:currency_exchange_tracker/shared/theme/extensions/app_spacing_ext.dart';
import 'package:currency_exchange_tracker/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme.light', () {
    final theme = AppTheme.light();

    test('is Material 3 and light brightness', () {
      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.light);
      expect(theme.colorScheme.brightness, Brightness.light);
    });

    test('carries the AppColors and AppSpacingExtension extensions', () {
      expect(theme.extension<AppColors>(), same(AppColors.light));
      expect(theme.extension<AppSpacingExtension>(),
          same(AppSpacingExtension.standard));
    });
  });

  group('AppTheme.dark', () {
    final theme = AppTheme.dark();

    test('is Material 3 and dark brightness', () {
      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.dark);
      expect(theme.colorScheme.brightness, Brightness.dark);
    });

    test('carries the dark AppColors extension', () {
      expect(theme.extension<AppColors>(), same(AppColors.dark));
    });
  });

  test('light and dark use distinct semantic colors', () {
    expect(AppColors.light.success, isNot(AppColors.dark.success));
    expect(AppColors.light.danger, isNot(AppColors.dark.danger));
  });

  group('AppColors.lerp', () {
    test('interpolates fields at t=0 and t=1', () {
      final atStart = AppColors.light.lerp(AppColors.dark, 0);
      final atEnd = AppColors.light.lerp(AppColors.dark, 1);
      expect(atStart.success, AppColors.light.success);
      expect(atEnd.success, AppColors.dark.success);
    });
  });

  group('AppSpacingExtension.lerp', () {
    test('interpolates at t=0 and t=1', () {
      const a = AppSpacingExtension(xs: 0, sm: 0, md: 0, lg: 0, xl: 0, xxl: 0);
      const b =
          AppSpacingExtension(xs: 10, sm: 10, md: 10, lg: 10, xl: 10, xxl: 10);
      expect(a.lerp(b, 0).md, 0);
      expect(a.lerp(b, 1).md, 10);
      expect(a.lerp(b, 0.5).md, 5);
    });
  });
}
