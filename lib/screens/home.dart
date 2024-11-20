import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'overview.dart';
import 'rating.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> movieList = [];
  //List<String> reviews = []; // Menyimpan review di HomePage
  Map<String, List<String>> movieReviews = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  final String apiPoster = 'https://image.tmdb.org/t/p/w185';
  final String apiBackdrop = 'https://image.tmdb.org/t/p/w500/';

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/now_playing?api_key=4cb9ec1672f2d32cd3869b29775f7fc2&language=en-US'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List movies = data['results'];

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

void navigateToRatingPage(String movieTitle, String movieBackdrop, double voteAverage, int voteCount, double popularity) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RatingPage(
        movieTitle: movieTitle,
        movieBackdrop: movieBackdrop,
        voteAverage: voteAverage,
        voteCount: voteCount,
        popularity: popularity,
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
              final movieVoteAverage = movieList[index]["vote_average"] ?? '';
              final movieVoteCount = movieList[index]["vote_count"] ?? '';
              final moviePopularity = movieList[index]["popularity"] ?? '';
              final fullPosterUrl = '$apiPoster$moviePoster';
              final fullBackdropUrl = '$apiBackdrop$movieBackdrop';

              return GestureDetector(
                onTap: () => navigateToOverviewPage(movieTitle, fullBackdropUrl, movieOverview, movieReleaseDate), // Pindah ke halaman ReviewPage
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
                              onPressed: () => navigateToRatingPage(movieTitle, fullBackdropUrl, movieVoteAverage, movieVoteCount, moviePopularity),
                              child: const Text('View Rating'),
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
