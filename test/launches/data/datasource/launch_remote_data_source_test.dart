import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:spacex/features/launches/data/datasources/spacex_remote_data_source.dart';
import 'package:spacex/features/launches/data/models/detail_launch_model.dart';
import 'package:spacex/features/launches/data/models/latest_launch_model.dart';
import 'package:spacex/features/launches/data/models/launch_model.dart';

import '../../../helpers/mock_helper.mocks.dart';


void main() {
  late LaunchRemoteDataSource dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = LaunchRemoteDataSource(mockClient);
  });

  group('fetchLaunches', () {
    final mockJson = {
      "docs": [
        {
          "id": "1",
          "name": "Falcon 9",
          "date_utc": "2024-01-01T00:00:00.000Z",
          "links": {
            "patch": {"small": "https://example.com/patch.png"},
          },
          "success": true,
          "upcoming": false,
        },
      ],
    };

    test('returns list of LaunchModel if statusCode is 200', () async {
      final uri = Uri.parse('https://api.spacexdata.com/v4/launches/query');

      when(mockClient.post(
        uri,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(jsonEncode(mockJson), 200));

      final result = await dataSource.fetchLaunches();

      expect(result, isA<List<LaunchModel>>());
      expect(result.first.id, '1');
      verify(mockClient.post(uri, headers: anyNamed('headers'), body: anyNamed('body'))).called(1);
    });

    test('throws Exception if response statusCode != 200', () async {
      final uri = Uri.parse('https://api.spacexdata.com/v4/launches/query');

      when(mockClient.post(uri, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Error', 500));

      expect(() => dataSource.fetchLaunches(), throwsException);
      verify(mockClient.post(uri, headers: anyNamed('headers'), body: anyNamed('body'))).called(1);
    });
  });

  group('fetchLatestLaunch', () {
    final mockJson = {
      "id": "2",
      "name": "Starship",
      "flight_number": 12,
      "date_utc": "2025-01-01T00:00:00.000Z",
      "links": {
        "patch": {"small": "https://example.com/patch.png"},
        "webcast": "https://youtube.com",
        "wikipedia": "https://wikipedia.org",
        "youtube_id": "yt123",
      },
      "success": true,
      "crew": [],
      "capsules": [],
      "payloads": [],
      "rocket": "rocket_1",
      "launchpad": "launchpad_1",
      "upcoming": false,
      "image_url": "https://example.com/patch.png",
    };

    test('returns LatestLaunchModel if statusCode is 200', () async {
      final uri = Uri.parse('https://api.spacexdata.com/v4/launches/latest');

      when(mockClient.get(uri)).thenAnswer((_) async => http.Response(jsonEncode(mockJson), 200));

      final result = await dataSource.fetchLatestLaunch();

      expect(result, isA<LatestLaunchModel>());
      expect(result.id, '2');
      verify(mockClient.get(uri)).called(1);
    });

    test('throws Exception if statusCode != 200', () async {
      final uri = Uri.parse('https://api.spacexdata.com/v4/launches/latest');

      when(mockClient.get(uri)).thenAnswer((_) async => http.Response('Error', 404));

      expect(() => dataSource.fetchLatestLaunch(), throwsException);
      verify(mockClient.get(uri)).called(1);
    });
  });

  group('fetchOneLaunch', () {
    final mockJson = {
      "id": "3",
      "name": "Demo Launch",
      "flight_number": 88,
      "date_utc": "2024-08-01T00:00:00.000Z",
      "links": {
        "patch": {"small": "https://example.com/patch.png"},
        "webcast": "https://youtube.com/demo",
        "wikipedia": "https://wiki.org/demo",
        "youtube_id": "yt456",
      },
      "success": true,
      "crew": [],
      "capsules": [],
      "payloads": [],
      "rocket": "rocket_3",
      "launchpad": "launchpad_3",
      "upcoming": false,
      "image_url": "https://example.com/patch.png",
      "details": "Demo mission",
    };

    test('returns DetailLaunchModel if statusCode is 200', () async {
      final uri = Uri.parse('https://api.spacexdata.com/v4/launches/3');

      when(mockClient.get(uri)).thenAnswer((_) async => http.Response(jsonEncode(mockJson), 200));

      final result = await dataSource.fetchOneLaunch('3');

      expect(result, isA<DetailLaunchModel>());
      expect(result.name, 'Demo Launch');
      verify(mockClient.get(uri)).called(1);
    });

    test('throws Exception if statusCode != 200', () async {
      final uri = Uri.parse('https://api.spacexdata.com/v4/launches/3');

      when(mockClient.get(uri)).thenAnswer((_) async => http.Response('Error', 500));

      expect(() => dataSource.fetchOneLaunch('3'), throwsException);
      verify(mockClient.get(uri)).called(1);
    });
  });
}
