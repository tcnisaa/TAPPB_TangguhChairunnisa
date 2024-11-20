import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'overview.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({super.key});

  @override
  State<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  List<Map<String, dynamic>> movieList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  final String apiPoster = 'https://image.tmdb.org/t/p/w185';
  final String apiBackdrop = 'https://image.tmdb.org/t/p/w500/';

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/upcoming?api_key=4cb9ec1672f2d32cd3869b29775f7fc2&language=en-US'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List movies = data['results'];

      // Extract "original_title" and "overview" from each movie
      setState(() {
        movieList.addAll(List<Map<String, dynamic>>.from(movies));
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  void navigateToOverviewPage(String movieTitle, String movieBackdrop, String overview, String releaseDate) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => OverviewPage(
        movieTitle: movieTitle,
        movieBackdrop: movieBackdrop,
        overview: overview,
        releaseDate: releaseDate,
      ),
    ),
  );
}

  // Widget untuk menampilkan konten utama
  Widget _buildContent() {
    return movieList.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: movieList.length,
            itemBuilder: (context, index) {
              final movieTitle = movieList[index]["original_title"] ?? 'No Title';
              final moviePoster = movieList[index]["poster_path"] ?? '';
              final movieBackdrop = movieList[index]["backdrop_path"] ?? '';
              final movieOverview = movieList[index]["overview"] ?? '';
              final movieReleaseDate = movieList[index]["release_date"] ?? '';
              final fullPosterUrl = '$apiPoster$moviePoster';
              final fullBackdropUrl = '$apiBackdrop$movieBackdrop';

              return GestureDetector(
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          fullPosterUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(child: Text('Image not available'));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              movieTitle,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            ElevatedButton(
                              onPressed: () => navigateToOverviewPage(movieTitle, fullBackdropUrl, movieOverview, movieReleaseDate),
                              child: const Text('View Synopsis'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DBS_MOVIE',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(255, 13, 105, 225),
      ),
      body: _buildContent(), // Panggil method untuk membangun konten
    );
  }
}
