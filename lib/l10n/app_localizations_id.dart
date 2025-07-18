// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get welcomeTo => 'Selamat Datang di\n';

  @override
  String get tourGuide => 'TourGuide';

  @override
  String get barcodeMismatch => 'Barcode Tidak Cocok';

  @override
  String get scanQrCode => 'Pindai Kode QR';

  @override
  String get languageChangedToEnglish => 'Language changed to English';

  @override
  String get languageChangedToIndonesian => 'Bahasa diubah ke Indonesia';

  @override
  String get nextStep => 'Lanjutkan';

  @override
  String get imageStep => 'Gambar ke-';

  @override
  String get panoramStep => 'Panorama ke-';

  @override
  String get appBartitle => 'Galeri Gambar';

  @override
  String get objectInfo => 'Info Objek';

  @override
  String get objectTag => 'Ini info penting objek';

  @override
  String get playSound => 'Putar Suara';
}
