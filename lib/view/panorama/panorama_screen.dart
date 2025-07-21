import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:pip_view/pip_view.dart';
import 'package:tourguide/components/assets.dart'; // Make sure you have your video assets here
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
  // State to hold the video path for the PiP window
  String? _pipVideoPath;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);

    return PIPView(
      builder: (context, isFloating) {
        // The PiP window will be built only if it's floating and a video path is set
        if (isFloating && _pipVideoPath != null) {
          return VideoPipWidget(videoPath: _pipVideoPath!);
        }
        // The main page view
        return Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: PanoramaViewer(
            animSpeed: 0.2,
            sensorControl: SensorControl.orientation,
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
                              onPressed: () {
                                final videoPath = locale.languageCode == 'en'
                                    ? AssetsVideo.videoHotspot1En
                                    : AssetsVideo.videoHotspot1Id;
                                _showVideoDialog(context, videoPath);
                                Navigator.of(context).pop();
                              },
                              child: const Text("Play Video"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Close"),
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
                          content: Text("${appLocalizations.objectTag} 1"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                final videoPath = locale.languageCode == 'en'
                                    ? AssetsVideo.videoHotspot2En
                                    : AssetsVideo.videoHotspot2Id;
                                _showVideoDialog(context, videoPath);
                                Navigator.of(context).pop();
                              },
                              child: const Text("Play Video"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Close"),
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

              // --- Hotspot 3 ---
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
                          content: Text("${appLocalizations.objectTag} 1"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                final videoPath = locale.languageCode == 'en'
                                    ? AssetsVideo.videoHotspot3En
                                    : AssetsVideo.videoHotspot3Id;
                                _showVideoDialog(context, videoPath);
                                Navigator.of(context).pop();
                              },
                              child: const Text("Play Video"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Close"),
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
      },
    );
  }

  // This function now accepts a videoPath to play a specific video
  Future<void> _showVideoDialog(BuildContext context, String videoPath) async {
    final controller = VideoPlayerController.asset(videoPath);
    await controller.initialize();
    controller.play();

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      barrierDismissible: false, // User must interact with the dialog
      builder: (BuildContext dialogContext) {
        return PopScope(
          // Ensure the controller is disposed when the dialog is closed
          // ignore: deprecated_member_use
          onPopInvoked: (_) => controller.dispose(),
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Column(
              mainAxisSize: MainAxisSize.min,
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
                            controller.value.isPlaying
                                ? controller.pause()
                                : controller.play();
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
                onPressed: () {
                  // Set the state with the video path for the PiP widget
                  setState(() {
                    _pipVideoPath = videoPath;
                  });
                  // Activate PiP mode
                  PIPView.of(context)?.presentBelow(const SizedBox.shrink());
                  // Close the dialog
                  Navigator.pop(dialogContext);
                },
                child: const Text("Minimize"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text("Tutup"),
              ),
            ],
          ),
        );
      },
    );
  }
}

// --- Modified VideoPipWidget ---
class VideoPipWidget extends StatefulWidget {
  // It now requires a videoPath
  final String videoPath;

  const VideoPipWidget({super.key, required this.videoPath});

  @override
  State<VideoPipWidget> createState() => _VideoPipWidgetState();
}

class _VideoPipWidgetState extends State<VideoPipWidget> {
  late final VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the provided video path
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        _controller.play();
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: SizedBox(
        width: 1.sw, // Use screen util for responsive size
        height: 1.sh,
        child: Stack(
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListenableBuilder(
                listenable: _controller,
                builder: (context, child) {
                  return IconButton(
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 36.sp,
                    ),
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
