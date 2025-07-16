import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourguide/components/routes.dart';
import 'package:tourguide/l10n/app_localizations.dart';
import 'package:tourguide/view/home_screen/onboard_screen.dart';
import 'package:tourguide/view/qr_screen/qr_screen.dart';
import 'package:tourguide/view/splash_screen/splash_screen.dart';
import 'package:tourguide/view/home_screen/main_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<Locale> _localeNotifier =
      ValueNotifier(const Locale('id')); // Default locale

  void setLocale(Locale newLocale) {
    if (_localeNotifier.value != newLocale) {
      _localeNotifier.value = newLocale;
    }
  }

  @override
  void initState() {
    super.initState();

    _localeNotifier.value = WidgetsBinding.instance.platformDispatcher.locale;
  }

  @override
  void dispose() {
    _localeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return ValueListenableBuilder(
            valueListenable: _localeNotifier,
            builder: (context, currenLocale, child) {
              return MaterialApp(
                title: 'Kemenkum For TA',
                debugShowCheckedModeBanner: false,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                initialRoute: '/',
                locale: currenLocale,
                builder: (context, child) {
                  return LocaleSetter(setLocale: setLocale, child: child!);
                },
                routes: {
                  Routes.homeScreen: (context) => MainPage(),
                  Routes.qrScreen: (context) => QrScreenAuth(),
                  Routes.splashScreen: (context) => SplashScreen(),
                  Routes.onBoardPage: (context) => OnboardScreen(),
                },
                home: SplashScreen(),
              );
            });
      },
    );
  }
}

class LocaleSetter extends InheritedWidget {
  const LocaleSetter({
    super.key,
    required this.setLocale,
    required super.child,
  });

  final Function(Locale) setLocale;

  static LocaleSetter? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LocaleSetter>();
  }

  @override
  bool updateShouldNotify(LocaleSetter oldWidget) => true;
}
