import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/launch.dart';

class LaunchRemoteDataSource {
  final http.Client client;

  LaunchRemoteDataSource(this.client);

  Future<List<Launch>> fetchUpcomingLaunches() async {
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

    return docs.map((json) {
      return Launch(
        id: json['id'],
        name: json['name'],
        dateUtc: DateTime.parse(json['date_utc']),
        imageUrl: json['links']['patch']['small'],
        success: json['success'],
        upcoming: json['upcoming'],
      );
    }).toList();
  }
}
