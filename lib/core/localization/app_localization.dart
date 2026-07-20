import 'package:flutter/widgets.dart';


abstract final class AppLocalization {
  const AppLocalization._();

  static const String path = 'assets/translations';

  static const Locale english = Locale('en');
  static const Locale arabic = Locale('ar');

  static const List<Locale> supported = [english, arabic];

  static const Locale fallback = english;
}
