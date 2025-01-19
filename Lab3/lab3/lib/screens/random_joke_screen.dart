import 'package:flutter/material.dart';
import 'package:lab2/models/joke.dart';
import 'package:lab2/services/jokes_api.dart';

class RandomJokeScreen extends StatelessWidget {
  final JokesApi jokesApi = JokesApi();

  RandomJokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Joke - 203213'),
      ),
      body: FutureBuilder(
        future: jokesApi.fetchRandomJoke(),
        builder:(context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data!.isEmpty) {
            throw Exception('Failed to load random joke');
          }
          final randomJoke = Joke.fromJson(snapshot.data!);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                snapshot.data!.isEmpty
                    ? const Text('No joke found')
                    : Column(
                        children: [
                          // Text(snapshot.data!['setup'])
                          Text(randomJoke.setup),
                          Text(randomJoke.punchline),
                        ],
                      ),
                // Text(randomJoke.setup),
                // Text(randomJoke.punchline),
              ],
            ),
          );
        },
      )
    );
  }
}