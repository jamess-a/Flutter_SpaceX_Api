import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spacex/features/launches/data/models/latest_launch_model.dart';
import 'package:spacex/features/launches/data/models/launch_model.dart';
import 'package:spacex/features/launches/data/models/detail_launch_model.dart';

class LaunchRemoteDataSource {
  final http.Client client;

  LaunchRemoteDataSource(this.client);

  Future<List<LaunchModel>> fetchLaunches({
    Map<String, dynamic>? query,
    Map<String, dynamic>? options,
  }) async {
    final response = await client.post(
      Uri.parse('https://api.spacexdata.com/v4/launches/query'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"query": query ?? {}, "options": options ?? {}}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load launches');
    }

    final jsonData = json.decode(response.body);
    final List<dynamic> docs = jsonData['docs'];

    return docs.map((json) => LaunchModel.fromJson(json)).toList();
  }

  Future<LatestLaunchModel> fetchLatestLaunch() async {
    final response = await client.get(
      Uri.parse('https://api.spacexdata.com/v4/launches/latest'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load latest launches');
    }
    final jsonData = json.decode(response.body);
    return LatestLaunchModel.fromJson(jsonData);
  }

  Future<GetOneLaunchModel> fetchOneLaunch(String id) async {
    print('Fetch ${id}');
    final response = await client.get(
      Uri.parse('https://api.spacexdata.com/v4/launches/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to load launches');
    }
    final jsonData = json.decode(response.body);
    print('data${jsonData}');
    return GetOneLaunchModel.fromJson(jsonData);
  }
}
