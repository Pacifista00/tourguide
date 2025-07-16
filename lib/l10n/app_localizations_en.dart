// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeTo => 'Welcome To\n';

  @override
  String get tourGuide => 'TourGuide';

  @override
  String get barcodeMismatch => 'Barcode Mismatch';

  @override
  String get scanQrCode => 'Scan QR Code';

  @override
  String get languageChangedToEnglish => 'Language changed to English';

  @override
  String get languageChangedToIndonesian => 'Bahasa diubah ke Indonesia';
}
