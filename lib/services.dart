import 'dart:convert';
import 'package:http/http.dart' as http;

class GiphyService {
  final String apiKey = 'QWSbEgaU1tH8INYq6uEXDzBGhI9NeGcC';
  final String baseUrl = 'https://api.giphy.com/v1/gifs';
  int offset = 0;
  final int limit = 25;

  Future<Map<String, dynamic>> fetchGifs(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search?api_key=$apiKey&q=$query&limit=$limit&offset=$offset'),
    );

    if (response.statusCode == 200) {
      offset += limit;
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load gifs');
    }
  }

  void resetOffset() {
    offset = 0;
  }
}
