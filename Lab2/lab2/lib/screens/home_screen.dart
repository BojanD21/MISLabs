import 'package:flutter/material.dart';
import 'package:lab2/screens/jokes_by_type_screen.dart';
import 'package:lab2/screens/random_joke_screen.dart';
import 'package:lab2/services/jokes_api.dart';

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<String>> data;

  @override
  void initState() {
    super.initState();
    data = JokesApi().fetchJokeTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text('Jokes App 203213'),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RandomJokeScreen()));
                },
              ),
            ],
          ),
        ),
        body: FutureBuilder<List<String>>(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text("No joke types found"));
              } else {
                final jokeTypes = snapshot.data;
                if (jokeTypes!.isEmpty) {
                  return Center(child: Text("No joke types found"));
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3),
                  itemCount: jokeTypes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  JokesByTypeScreen(type: jokeTypes[index]),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(jokeTypes[index]),
                        ),
                      ),
                    );
                  },
                );
              }
            }));
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
