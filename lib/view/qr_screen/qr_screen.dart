import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tourguide/bloc/qr_code_cubit/qr_cubit.dart';
import 'package:tourguide/components/routes.dart';
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
  Barcode? _barcode;

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
        // Stop the scanner when the app is paused.
        // Also stop the barcode events subscription.
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(_controller.stop());
    }
  }

  void handleScannedBarcode(BarcodeCapture capture) {
    final Barcode? barcode =
        capture.barcodes.isNotEmpty ? capture.barcodes.first : null;
    final String? rawValue = barcode?.rawValue;
    if (rawValue != null && rawValue == "t0urgu1de") {
      debugPrint("Hasil dari scanner $rawValue ");
      context.read<QrCubit>().setQrResult(rawValue);
      Navigator.pushReplacementNamed(context, Routes.onBoardPage);
    } else {
      print("Barcode kosong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100.h),
              Text.rich(
                TextSpan(
                  text: "Welcome To\n",
                  style: GoogleFonts.notoSansSamaritan(
                    fontSize: 20.sp,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "TourGuide",
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
          Spacer(),
          buttonAction(context, handleScannedBarcode, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ScannerPage(onDetect: handleScannedBarcode);
                },
              ),
            );
          }, "Scan Qr Code"),
        ],
      ),
    );
  }
}
