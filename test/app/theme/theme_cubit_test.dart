import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange_tracker/app/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive_ce.dart';

void main() {
  late Directory hiveDir;
  late Box box;

  setUp(() async {
    hiveDir = Directory.systemTemp.createTempSync('theme_cubit_test_');
    Hive.init(hiveDir.path);
    box = await Hive.openBox('settings_box');
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
    hiveDir.deleteSync(recursive: true);
  });

  test('defaults to ThemeMode.system when nothing is persisted', () {
    final cubit = ThemeCubit(box);
    expect(cubit.state, ThemeMode.system);
  });

  test('reads the persisted mode on construction', () async {
    await box.put('theme_mode', ThemeMode.dark.name);
    final cubit = ThemeCubit(box);
    expect(cubit.state, ThemeMode.dark);
  });

  blocTest<ThemeCubit, ThemeMode>(
    'setMode emits the new mode and persists it',
    build: () => ThemeCubit(box),
    act: (cubit) => cubit.setMode(ThemeMode.dark),
    expect: () => [ThemeMode.dark],
    verify: (_) => expect(box.get('theme_mode'), ThemeMode.dark.name),
  );

  blocTest<ThemeCubit, ThemeMode>(
    'setMode is a no-op when the mode is unchanged',
    build: () => ThemeCubit(box),
    act: (cubit) => cubit.setMode(ThemeMode.system),
    expect: () => <ThemeMode>[],
  );

  blocTest<ThemeCubit, ThemeMode>(
    'toggle flips between light and dark',
    build: () => ThemeCubit(box),
    act: (cubit) {
      cubit.setMode(ThemeMode.light);
      cubit.toggle();
      cubit.toggle();
    },
    expect: () => [ThemeMode.light, ThemeMode.dark, ThemeMode.light],
  );
}
