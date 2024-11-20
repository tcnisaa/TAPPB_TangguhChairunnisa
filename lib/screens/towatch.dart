import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToWatchPage extends StatefulWidget {
  const ToWatchPage({super.key});

  @override
  _ToWatchPageState createState() => _ToWatchPageState();
}

class _ToWatchPageState extends State<ToWatchPage> {
  List<String> _movies = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _movies = prefs.getStringList('movies') ?? [];
    });
  }

  Future<void> _saveMovies() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('movies', _movies);
  }

  void _addMovie() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _movies.add(_controller.text);
      });
      _saveMovies();  // Save the updated list
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie List',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
        )),
        backgroundColor: const Color.fromARGB(255, 13, 105, 225),
      ),
      body: Center(
        child: _movies.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No movies added yet!'),
                  ElevatedButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Add a Movie'),
                          content: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              hintText: 'Enter movie name',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                _addMovie();
                                Navigator.pop(context);
                              },
                              child: const Text('Add'),
                            ),
                          ],
                        );
                      },
                    ),
                    child: const Text('Add Movie'),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_movies[index]),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Add a Movie'),
              content: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter movie name',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    _addMovie();
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
