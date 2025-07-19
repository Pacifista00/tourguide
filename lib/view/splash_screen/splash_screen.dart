import 'package:flutter/material.dart';
import 'package:tourguide/components/assets.dart';
import 'package:tourguide/components/routes.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return; // Pastikan widget masih aktif
      Navigator.pushReplacementNamed(context, Routes.onBoardPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(child: Image.asset(Assets.logoBackground, width: 200)),
    );
  }
}
