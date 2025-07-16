import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tourguide/l10n/app_localizations.dart';

class ScannerPage extends StatefulWidget {
  final Function(BarcodeCapture) onDetect;
  // final MobileScannerController mobileScannerController;

  const ScannerPage({
    super.key,
    required this.onDetect,
    // required this.mobileScannerController,
  });

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.scanQrCode)),
      body: MobileScanner(
        // controller: widget.mobileScannerController,
        onDetect: widget.onDetect,
      ),
    );
  }
}
