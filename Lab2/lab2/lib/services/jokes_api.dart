import 'dart:convert';
import 'package:http/http.dart' as http;

class JokesApi {
  static const String baseUrl = 'https://official-joke-api.appspot.com';
  
  // Fetch joke types
  Future<List<String>> fetchJokeTypes() async {
    final response = await http.get(Uri.parse("$baseUrl/types"));

    if (response.statusCode != 200){
      throw Exception('Failed to load joke types');
    }

    return List<String>.from(jsonDecode(response.body));
  }

  Future<List<Map<String, dynamic>>> fetchJokesByType(String type) async {
    final response = await http.get(Uri.parse("$baseUrl/jokes/$type/ten"));

    if(response.statusCode != 200){
      throw Exception('Failed to load jokes');
    }

    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  }

  Future<Map<String, dynamic>> fetchRandomJoke() async {
    final response = await http.get(Uri.parse("$baseUrl/random_joke"));

    if(response.statusCode != 200){
      throw Exception('Failed to load random joke');
    }

    return jsonDecode(response.body);
  }

}