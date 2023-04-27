import 'dart:convert';
import 'package:http/http.dart' as http;

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();
Future<List<dynamic>> searchPhotos(String query) async {
    final String apiUrl = 'https://api.unsplash.com/search/photos';
    final String apiKey = 'MPMWGDZsY_QPZMtE3H-_Ff_jDq34DGcT7qd76GN7DZ8';

    final response =
        await http.get(Uri.parse('$apiUrl?query=$query&client_id=$apiKey'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['results'];
    } else {
      throw Exception('Failed to load photos');
    }
  }

}

  

