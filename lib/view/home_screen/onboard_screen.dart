import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourguide/components/assets.dart';
import 'package:tourguide/components/routes.dart';
import 'package:tourguide/widget/button.dart';
import 'package:just_audio/just_audio.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  late AudioPlayer _player;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.setAsset(AssetsAudio.audioOnboard); // Preload audio

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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100.h),
          InkWell(
            onTap: () => _playSound(),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 250.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.objekOnboard),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
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
                ),
              ],
            ),
          ),

          SizedBox(height: 50.h),
          buttonAction(context, null, () {
            Navigator.pushNamed(context, Routes.homeScreen);
          }, "Lanjutkan"),
        ],
      ),
    );
  }
}
