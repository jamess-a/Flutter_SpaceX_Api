import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spacex/features/launches/data/models/detail_crew_model.dart';
import 'package:spacex/features/launches/data/models/detail_launchpad_model.dart';
import 'package:spacex/features/launches/data/models/detail_rocket_model.dart';
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
    final response = await client.get(
      Uri.parse('https://api.spacexdata.com/v4/launches'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load launches');
    }

    final jsonData = json.decode(response.body) as List<dynamic>;

    return jsonData.map((json) => LaunchModel.fromJson(json)).toList();
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

  Future<DetailLaunchModel> fetchOneLaunch(String id) async {
    final response = await client.get(
      Uri.parse('https://api.spacexdata.com/v4/launches/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to load launches');
    }
    final jsonData = json.decode(response.body);
    return DetailLaunchModel.fromJson(jsonData);
  }

  Future<DetailRocketModel> fetchOneRocket(String id) async {
    final response = await client.get(
      Uri.parse('https://api.spacexdata.com/v4/rockets/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to load launches');
    }
    final jsonData = json.decode(response.body);
    return DetailRocketModel.fromJson(jsonData);
  }

  Future<List<DetailCrewModel>> fetchallCrews(List<String> ids) async {
    final response = await client.post(
      Uri.parse('https://api.spacexdata.com/v4/crew/query'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "query": {
          "_id": {"\$in": ids},
        },
        "options": {"pagination": false},
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load crews (${response.statusCode})');
    }

    final data = json.decode(response.body);

    return (data['docs'] as List)
        .map((e) => DetailCrewModel.fromJson(e))
        .toList();
  }

  Future<DetailLaunchpadModel> fetchOneLaunchPad(String id) async {
    final response = await client.get(
      Uri.parse('https://api.spacexdata.com/v4/launchpads/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load launchpads');
    } else {
      final jsonData = json.decode(response.body);
      return DetailLaunchpadModel.fromJson(jsonData);
    }
  }
}
