import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tourguide/components/assets.dart';
import 'package:tourguide/components/routes.dart';
import 'package:tourguide/l10n/app_localizations.dart';
import 'package:tourguide/widget/button.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final locale = Localizations.localeOf(context);
      final audioPath = locale.languageCode == 'en'
          ? AssetsAudio.audioOnboarden
          : AssetsAudio.audioOnboard;

      await _player.setAsset(audioPath); // Preload audio sesuai bahasa
    }); //

    _player.playerStateStream.listen((state) {
      setState(() {
        isPlaying =
            state.playing && state.processingState != ProcessingState.completed;
      });
    });
  }

  Future<void> _playSound() async {
    try {
      if (isPlaying) {
        await _player.pause();
      } else {
        await _player.seek(Duration.zero);
        await _player.play();
      }
    } catch (e) {
      debugPrint("Gagal memutar audio: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Column(
              children: [
                SizedBox(height: 50.h),

                // Gambar + Tombol Play/Pause
                InkWell(
                  onTap: _playSound,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 250.w,
                        height: 200.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.w),
                          image: DecorationImage(
                            image: AssetImage(Assets.objekOnboard),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(12.w),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            key: ValueKey(isPlaying),
                            size: 40.w,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Deskripsi
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    appLocalizations.description,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.justify,
                  ),
                ),

                SizedBox(height: 40.h),

                // Tombol Lanjut
                buttonAction(
                  context,
                  null,
                  () => Navigator.pushNamed(context, Routes.homeScreen),
                  appLocalizations.nextStep,
                  Colors.amber,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
