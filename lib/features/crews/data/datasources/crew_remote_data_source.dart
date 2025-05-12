import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spacex/features/crews/data/models/crew_model.dart';

class CrewsRemoteDataSource {
  final http.Client client;

  CrewsRemoteDataSource(this.client);

  Future<List<CrewModel>> fetchCrews({
    Map<String, dynamic>? query,
    Map<String, dynamic>? options,
  }) async {
    final response = await client.post(
      Uri.parse('https://api.spacexdata.com/v4/crew/query'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"query": query ?? {}, "options": options ?? {}}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load launches');
    }

    final jsonData = json.decode(response.body);
    final List<dynamic> docs = jsonData['docs'];

    return docs.map((json) => CrewModel.fromJson(json)).toList();
  }
}
