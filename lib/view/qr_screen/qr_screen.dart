import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tourguide/bloc/qr_code_cubit/qr_cubit.dart';
import 'package:tourguide/components/routes.dart';
// Correct import for the generated localization file

import 'package:tourguide/l10n/app_localizations.dart';
import 'package:tourguide/main.dart';
import 'package:tourguide/view/qr_screen/scanner_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide/widget/button.dart';

class QrScreenAuth extends StatefulWidget {
  const QrScreenAuth({super.key});

  @override
  State<QrScreenAuth> createState() => _QrScreenAuthState();
}

class _QrScreenAuthState extends State<QrScreenAuth> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return QrCubit();
      },
      child: const QrScreen(),
    );
  }
}
// --- (End of QrScreenAuth) ---

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController(
    autoStart: false,
  );
  StreamSubscription<Object?>? _subscription;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_controller.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = _controller.barcodes.listen(handleScannedBarcode);
        unawaited(_controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(_controller.stop());
    }
  }

  void handleScannedBarcode(BarcodeCapture capture) {
    final Barcode? barcode =
        capture.barcodes.isNotEmpty ? capture.barcodes.first : null;
    final String? rawValue = barcode?.rawValue;

    // Get the localized strings
    final appLocalizations = AppLocalizations.of(context)!;

    if (rawValue != null && rawValue == "t0urgu1de") {
      debugPrint("Hasil dari scanner $rawValue ");
      context.read<QrCubit>().setQrResult(
            rawValue,
          );
      Navigator.pushReplacementNamed(context, Routes.onBoardPage);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(appLocalizations.barcodeMismatch), // Localized string
        ),
      );
    }
  }

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    _subscription = null;
    unawaited(_controller.dispose());
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Access the AppLocalizations instance
    final appLocalizations = AppLocalizations.of(context)!;
    final currentLocale = Localizations.localeOf(context);

    final setLocale = LocaleSetter.of(context)!
        .setLocale; // --> function localesetter ada di main.dart

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language, color: Colors.black),
            onSelected: (value) {
              if (value == 'id') {
                setLocale(const Locale('id')); // Set locale to Indonesian
              } else if (value == 'en') {
                setLocale(const Locale('en')); // Set locale to English
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'id',
                child: Row(
                  children: [
                    Text('Indonesia'), // pindah ke bahasa indonesia
                    SizedBox(width: 20.w),

                    if (currentLocale.languageCode == 'id')
                      Icon(
                        Icons.done_all_outlined,
                        color: Colors.green, // Indicate selection
                      ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'en',
                child: Row(
                  children: [
                    Text("English"), // Pindah ke Bahasa Inggris
                    SizedBox(width: 20.w),

                    if (currentLocale.languageCode == 'en')
                      Icon(
                        Icons.done_all_outlined,
                        color: Colors.green,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100.h),
              Text.rich(
                TextSpan(
                  text: appLocalizations.welcomeTo, // Use localized string
                  style: GoogleFonts.notoSansSamaritan(
                    fontSize: 20.sp,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: appLocalizations.tourGuide, // Use localized string
                      style: GoogleFonts.notoSansSamaritan(
                        fontSize: 17.sp,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const Spacer(),
          buttonAction(context, handleScannedBarcode, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ScannerPage(onDetect: handleScannedBarcode);
                },
              ),
            );
          }, appLocalizations.scanQrCode),
        ],
      ),
    );
  }
}
