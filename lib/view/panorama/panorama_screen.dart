import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:tourguide/components/assets.dart';
import 'package:tourguide/l10n/app_localizations.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: PanoramaViewer(
        animSpeed: 0,
        zoom: 0.002,
        sensorControl: SensorControl.none,
        hotspots: [
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
                            await _playSound();
                          },
                          child: Text(isPlaying
                              ? "Jeda Audio"
                              : appLocalizations.playSound),
                        ),
                        TextButton(
                          onPressed: () async {
                            await _playSound();
                            Navigator.pop(context);
                          },
                          child: const Text("Tutup"),
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
                            await _playSound();
                          },
                          child: Text(isPlaying
                              ? "Jeda Audio"
                              : appLocalizations.playSound),
                        ),
                        TextButton(
                          onPressed: () async {
                            await _playSound();
                            Navigator.pop(context);
                          },
                          child: const Text("Tutup"),
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
                      content: Text("${appLocalizations.objectTag} 3"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            await _playSound();
                          },
                          child: Text(isPlaying
                              ? "Jeda Audio"
                              : appLocalizations.playSound),
                        ),
                        TextButton(
                          onPressed: () async {
                            await _playSound();
                            Navigator.pop(context);
                          },
                          child: const Text("Tutup"),
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
  }
}
