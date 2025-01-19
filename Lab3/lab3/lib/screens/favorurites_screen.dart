import 'package:flutter/material.dart';
import 'package:lab2/services/favourites_service.dart'; // Import the FavoritesService

class FavoruritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: FutureBuilder(
        future: FavouritesService.loadFavourites(), // Load favorites
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorites yet!'));
          }

          final favorites = snapshot.data as List<Map<String, String>>;

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final joke = favorites[index];
              return ListTile(
                title: Text(joke['setup']!),
                subtitle: Text(joke['punchline']!),
                trailing: IconButton(
                  icon: Icon(Icons.star),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Removed from favorites'),
                      ),
                    );
                    favorites.removeAt(index);
                    FavouritesService.saveFavorites(favorites);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
