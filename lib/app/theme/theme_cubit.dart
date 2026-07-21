import 'dart:async' show unawaited;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive_ce.dart';


class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._settingsBox) : super(_readInitial(_settingsBox));

  static const String _key = 'theme_mode';

  final Box _settingsBox;

  static ThemeMode _readInitial(Box box) {
    final stored = box.get(_key) as String?;
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == stored,
      orElse: () => ThemeMode.system,
    );
  }

  void setMode(ThemeMode mode) {
    if (mode == state) return;
    emit(mode);
    unawaited(_settingsBox.put(_key, mode.name));
  }

  void toggle() =>
      setMode(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
}
