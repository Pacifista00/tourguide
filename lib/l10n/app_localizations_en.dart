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
  String get tourGuide => 'TourGuide\n';

  @override
  String get barcodeMismatch => 'Barcode Mismatch';

  @override
  String get scanQrCode => 'Scan QR Code';

  @override
  String get languageChangedToEnglish => 'Language changed to English';

  @override
  String get languageChangedToIndonesian => 'Bahasa diubah ke Indonesia';

  @override
  String get nextStep => 'Next';

  @override
  String get imageStep => 'Image-';

  @override
  String get panoramStep => 'Panorama-';

  @override
  String get appBartitle => 'Image Galery';

  @override
  String get objectInfo => 'Object Information';

  @override
  String get objectTag => 'This is an main object';

  @override
  String get playSound => 'Play Video';

  @override
  String get description =>
      'Sam Poo Kong is a historic temple that reflects a blend of Chinese and Javanese cultures. It was built at a location believed to have been visited by Admiral Zheng He in 1416. The site originated from a stone cave used for worship, and it has since evolved into a grand temple complex, with the main building reconstructed between 2002 and 2005.';
}
