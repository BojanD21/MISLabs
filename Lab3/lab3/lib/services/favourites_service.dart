import 'dart:convert'; // For jsonDecode
import 'package:shared_preferences/shared_preferences.dart'; // For SharedPreferences


class FavouritesService {
static const _favoritesKey = 'favorites';

  // Load favorite jokes from SharedPreferences
  static Future<List<Map<String, String>>> loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    String? favoritesString = prefs.getString(_favoritesKey);
    if (favoritesString != null) {
      List<dynamic> decodedList = json.decode(favoritesString);
      return decodedList.map((item) => Map<String, String>.from(item)).toList();
    }
    return []; // Return an empty list if no favorites are found
  }

  // Save favorite jokes to SharedPreferences
  static Future<void> saveFavorites(List<Map<String, String>> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    String encodedFavorites = json.encode(favorites);
    prefs.setString(_favoritesKey, encodedFavorites);
  }

  // Add a joke to favorites
  static Future<void> addFavorite(Map<String, String> joke) async {
    List<Map<String, String>> favorites = await loadFavourites();
    favorites.add(joke);  // Add the new joke to the list
    await saveFavorites(favorites);  // Save the updated list back to SharedPreferences

    // Debugging statement
    print('Favorite added: $joke');
  }
}