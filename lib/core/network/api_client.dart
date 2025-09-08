import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client client;

  ApiClient(this.client);

  Future<List<dynamic>> searchPlacesRaw(String query) async {
    final uri = Uri.parse('https://us1.locationiq.com/v1/search.php').replace(
      queryParameters: {
        'key': 'pk.b8e4549181d0456520ca2ee28012be9e',
        'q': query,
        'format': 'json',
        'limit': '1',
      },
    );

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.body}');
    }
  }
}
