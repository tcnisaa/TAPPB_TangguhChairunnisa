import 'package:flutter/material.dart';
import './widget/navigation.dart';

void main() {
  runApp(const MangaApp());
}

class MangaApp extends StatelessWidget {
  const MangaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FavMovies',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 4, 195, 10),
        ),
        useMaterial3: true,
      ),
      home: const NavigationPage(),
    );
  }
}
