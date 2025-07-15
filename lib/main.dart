import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourguide/components/routes.dart';
import 'package:tourguide/view/home_screen/onboard_screen.dart';
import 'package:tourguide/view/qr_screen/qr_screen.dart';
import 'package:tourguide/view/splash_screen/splash_screen.dart';
import 'package:tourguide/view/home_screen/main_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Kemenkum For TA',
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            Routes.homeScreen: (context) => MainPage(),
            Routes.qrScreen: (context) => QrScreenAuth(),
            Routes.splashScreen: (context) => SplashScreen(),
            Routes.onBoardPage: (context) => OnboardScreen(),
          },
          home: SplashScreen(),
        );
      },
    );
  }
}
