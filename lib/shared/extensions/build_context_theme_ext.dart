import 'package:flutter/material.dart';

import '../theme/extensions/app_color_ext.dart';
import '../theme/extensions/app_spacing_ext.dart';


extension BuildContextThemeX on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;

  AppSpacingExtension get spacing =>
      Theme.of(this).extension<AppSpacingExtension>()!;

  TextTheme get textStyles => Theme.of(this).textTheme;
}
