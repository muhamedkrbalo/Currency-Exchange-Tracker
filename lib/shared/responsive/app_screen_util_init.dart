import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppScreenUtilInit extends StatelessWidget {
  const AppScreenUtilInit({required this.builder, super.key});

  static const Size designSize = Size(390, 844);

  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => builder(context),
    );
  }
}
