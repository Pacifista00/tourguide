import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar path gambar (pastikan gambar ini ada di assets/images/)
    final List<String> gambarList = [
      'assets/gambar.jpg',
      'assets/gambar.jpg',
      'assets/gambar.jpg',
      'assets/gambar.jpg',
      'assets/gambar.jpg',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Galeri Gambar')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: gambarList.length,
        itemBuilder: (context, index) {
          return Card(
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
          );
        },
      ),
    );
  }
}
