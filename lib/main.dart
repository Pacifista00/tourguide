import 'package:flutter/material.dart';
import 'package:tourguide/components/splash_screen.dart';
import 'package:tourguide/pages/main_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kemenkum For TA',
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      // navigasi dari semua halaman
      routes: {'/main': (context) => const MainPage()},
    );
  }
}
