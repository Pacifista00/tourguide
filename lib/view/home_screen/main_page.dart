import 'package:flutter/material.dart';
import 'package:tourguide/components/assets.dart';
import 'package:tourguide/l10n/app_localizations.dart';
import 'package:tourguide/view/panorama/panorama_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final List<String> gambarList = [
      Assets.panoramic1,
      Assets.panoramic2,
      Assets.panoramic3,
    ];

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.appBartitle)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: gambarList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PanoramaViewPage(
                    imagePath: gambarList[index],
                    title: '${appLocalizations.panoramStep}${index + 1}',
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  Image.asset(gambarList[index], fit: BoxFit.cover),
                  const SizedBox(height: 5),
                  Text(
                    '${appLocalizations.imageStep}${index + 1}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
