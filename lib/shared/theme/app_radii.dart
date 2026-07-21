import 'package:flutter/material.dart';


abstract final class AppRadii {
  const AppRadii._();

  static const double sm = 4;
  static const double md = 8;
  static const double lg = 16;
  static const double full = 999;

  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius radiusFull =
      BorderRadius.all(Radius.circular(full));
}
