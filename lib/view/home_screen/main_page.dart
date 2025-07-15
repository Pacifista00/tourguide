import 'package:flutter/material.dart';
import 'package:tourguide/components/assets.dart';
import 'package:tourguide/view/panorama/panorama_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> gambarList = [
      Assets.panoramic1,
      Assets.panoramic2,
      Assets.panoramic3,
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Galeri Gambar')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: gambarList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => PanoramaViewPage(
                        imagePath: gambarList[index],
                        title: 'Panorama ke-${index + 1}',
                      ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  Image.asset(gambarList[index], fit: BoxFit.cover),
                  const SizedBox(height: 8),
                  Text(
                    'Gambar ke-${index + 1}',
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
