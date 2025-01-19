import 'package:flutter/material.dart';
import 'package:lab2/services/favourites_service.dart';
import 'package:lab2/services/jokes_api.dart';

class JokesByTypeScreen extends StatelessWidget {
  final String type;
  final JokesApi jokesApi = JokesApi();

  JokesByTypeScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: Text("${type[0].toUpperCase()}${type.substring(1)} Jokes - 203213"),
        ),
        body: FutureBuilder(
            future: jokesApi.fetchJokesByType(type),
            builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                } else if (snapshot.hasError || snapshot.data!.isEmpty){
                    throw Exception('Failed to load jokes by type: $type');
                }

                return ListView.builder(itemBuilder: (context, index){
                    return ListTile(
                      title: Text(snapshot.data![index]['setup']),
                      subtitle: Text(snapshot.data![index]['punchline']),
                      trailing: IconButton(
                        icon: Icon(Icons.star_border),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added to favorites'),
                            ),
                          );
                          final joke = snapshot.data![index];
                          Map<String, String> jokeData = {
                            'setup': joke['setup'],
                            'punchline': joke['punchline'],
                          };

                          FavouritesService.addFavorite(jokeData);

                        },
                      ),
                    );
                }, itemCount: snapshot.data!.length);
            },
        )
    );
  }

}