import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/di/injection.dart';
import '../core/localization/locale_keys.dart';
import '../shared/responsive/app_screen_util_init.dart';
import '../shared/theme/app_theme.dart';
import 'router/app_router.dart';
import 'theme/theme_cubit.dart';

class CurrencyExchangeApp extends StatefulWidget {
  const CurrencyExchangeApp({super.key});

  @override
  State<CurrencyExchangeApp> createState() => _CurrencyExchangeAppState();
}

class _CurrencyExchangeAppState extends State<CurrencyExchangeApp> {
  late final GoRouter _router = AppRouter.create();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (_) => getIt<ThemeCubit>(),
      child: AppScreenUtilInit(
        builder: (context) => BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) => MaterialApp.router(
            title: LocaleKeys.app_title.tr(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: themeMode,
            routerConfig: _router,
          ),
        ),
      ),
    );
  }
}
