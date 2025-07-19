import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:pip_view/pip_view.dart';
import 'package:tourguide/components/assets.dart';
import 'package:tourguide/l10n/app_localizations.dart';

import 'package:video_player/video_player.dart';

class PanoramaViewPage extends StatefulWidget {
  final String imagePath;
  final String title;

  const PanoramaViewPage({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  State<PanoramaViewPage> createState() => _PanoramaViewPageState();
}

class _PanoramaViewPageState extends State<PanoramaViewPage> {
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    // _player.setAsset(AssetsAudio.audioOnboard);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final locale = Localizations.localeOf(context);
      final audioPath = locale.languageCode == 'en'
          ? AssetsAudio.audioOnboarden
          : AssetsAudio.audioOnboard;

      await _player.setAsset(audioPath); // Preload audio sesuai bahasa
    }); // Preload audio

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
    return PIPView(builder: (context, isFloating) {
      if (isFloating) {
        // Ini yang muncul saat minimize
        return const VideoPipWidget();
      }
      return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: PanoramaViewer(
          animSpeed: 0,
          zoom: 0.002,
          sensorControl: SensorControl.none,
          hotspots: [
            //1
            Hotspot(
              latitude: 0,
              longitude: 60,
              width: 60,
              height: 60,
              widget: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text(appLocalizations.objectInfo),
                        content: Text("${appLocalizations.objectTag} 1"),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              _playVideoController(context);
                              Navigator.pop(context);
                            },
                            child: Text(isPlaying
                                ? "Jeda Audio"
                                : appLocalizations.playSound),
                          ),
                          TextButton(
                            onPressed: () async {
                              PIPView.of(context)?.presentBelow(
                                  PanoramaViewPage(
                                      imagePath: widget.imagePath,
                                      title: widget.title));
                              Navigator.pop(context);
                            },
                            child: const Text("Minimize"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.info, color: Colors.black),
                ),
              ),
            ),

            //tiktik spot 2
            Hotspot(
              latitude: 0,
              longitude: 90,
              width: 180,
              height: 60,
              widget: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text(appLocalizations.objectInfo),
                        content: Text("${appLocalizations.objectTag} 2"),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              _playVideoController(context);
                              Navigator.pop(context);
                            },
                            child: Text(isPlaying
                                ? "Jeda Audio"
                                : appLocalizations.playSound),
                          ),
                          TextButton(
                            onPressed: () async {
                              PIPView.of(context)?.presentBelow(
                                  PanoramaViewPage(
                                      imagePath: widget.imagePath,
                                      title: widget.title));
                              Navigator.pop(context);
                            },
                            child: const Text("Minimize"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.info, color: Colors.black),
                ),
              ),
            ),

            Hotspot(
              latitude: -25,
              longitude: 357,
              width: 180,
              height: 60,
              widget: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text(appLocalizations.objectInfo),
                        content: Text("${appLocalizations.objectTag} 2"),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              _playVideoController(context);
                              Navigator.pop(context);
                            },
                            child: Text(isPlaying
                                ? "Jeda Audio"
                                : appLocalizations.playSound),
                          ),
                          TextButton(
                            onPressed: () async {
                              PIPView.of(context)?.presentBelow(
                                  PanoramaViewPage(
                                      imagePath: widget.imagePath,
                                      title: widget.title));
                              Navigator.pop(context);
                            },
                            child: const Text("Minimize"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.info, color: Colors.black),
                ),
              ),
            ),
          ],
          child: Image.asset(widget.imagePath),
        ),
      );
    });
  }

  Future<void> _playVideoController(BuildContext context) async {
    final controller = VideoPlayerController.asset(AssetsVideo.videoPenjelasan);

    await controller.initialize();
    controller.play();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero, // Remove default padding
          content: Column(
            mainAxisSize: MainAxisSize.min, // Keep the column compact
            children: [
              AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
              ListenableBuilder(
                listenable: controller,
                builder: (context, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                        onPressed: () {
                          if (controller.value.isPlaying) {
                            controller.pause();
                          } else {
                            controller.play();
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                PIPView.of(context)?.presentBelow(PanoramaViewPage(
                    imagePath: widget.imagePath, title: widget.title));
                Navigator.pop(context);
              },
              child: const Text("Minimize"),
            ),
          ],
        );
      },
    );
  }
}

class VideoPipWidget extends StatefulWidget {
  const VideoPipWidget({super.key});

  @override
  State<VideoPipWidget> createState() => _VideoPipWidgetState();
}

class _VideoPipWidgetState extends State<VideoPipWidget> {
  late final VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(AssetsVideo.videoPenjelasan)
      ..initialize().then((_) {
        controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      width: 500.w,
      height: 450.h,
      child: Stack(
        children: [
          VideoPlayer(controller),
          Align(
            alignment: Alignment.bottomCenter,
            child: IconButton(
              icon: Icon(
                controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  controller.value.isPlaying
                      ? controller.pause()
                      : controller.play();
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
