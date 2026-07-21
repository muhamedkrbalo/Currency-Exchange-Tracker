import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import 'app/theme/theme_cubit.dart';
import 'core/config/hive_boxes.dart';
import 'core/di/injection.dart';
import 'core/localization/app_localization.dart';
import 'core/localization/locale_keys.dart';
import 'shared/responsive/app_screen_util_init.dart';
import 'shared/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveBoxes.settings);
  await configureDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: AppLocalization.supported,
      path: AppLocalization.path,
      fallbackLocale: AppLocalization.fallback,
      child: const CurrencyExchangeApp(),
    ),
  );
}

class CurrencyExchangeApp extends StatelessWidget {
  const CurrencyExchangeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (_) => getIt<ThemeCubit>(),
      child: AppScreenUtilInit(
        builder: (context) => BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) => MaterialApp(
            title: LocaleKeys.app_title.tr(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: themeMode,
            home: const Scaffold(
              body: Center(
                child: Text('Currency Exchange Tracker'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
