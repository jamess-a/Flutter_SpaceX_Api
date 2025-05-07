import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spacex/features/launches/data/models/launch_model.dart';

class LaunchRemoteDataSource {
  final http.Client client;

  LaunchRemoteDataSource(this.client);

  Future<List<LaunchModel>> fetchUpcomingLaunches() async {
    final response = await client.post(
      Uri.parse('https://api.spacexdata.com/v4/launches/query'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "query": {},
        "options": {
          "limit": 20,
          "sort": {"date_utc": "asc"},
        },
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load launches');
    }

    final jsonData = json.decode(response.body);
    final List<dynamic> docs = jsonData['docs'];

    return docs.map((json) => LaunchModel.fromJson(json)).toList();
  }
}
