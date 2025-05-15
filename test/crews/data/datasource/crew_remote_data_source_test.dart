import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:spacex/features/crews/data/datasources/crew_remote_data_source.dart';
import 'package:spacex/features/crews/data/models/crew_model.dart';

import '../../../helpers/mock_helper.mocks.dart';

void main() {
  late CrewsRemoteDataSource dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = CrewsRemoteDataSource(mockClient);
  });

  group('fetchCrews', () {
    final mockJson = {
      "docs": [
        {
          "name": "Test1",
          "agency": "NASA",
          "image": "https://example.com/patch.p/queryng",
          "wikipedia": "https://en.wikipedia.org/wiki/test",
          "launches": ["123"],
          "status": "active",
          "id": "1234",
        },
        {
          "name": "Test2",
          "agency": "JAXA",
          "image": "https://example.com/patch.p/queryng",
          "wikipedia": "https://en.wikipedia.org/wiki/test",
          "launches": ["456"],
          "status": "active",
          "id": "5678",
        },
      ],
    };

    test('return list of Crews if status is 200', () async {
      final uri = Uri.parse('https://api.spacexdata.com/v4/crew/query');

      when(
        mockClient.post(
          uri,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(mockJson), 200));

      final result = await dataSource.fetchCrews();
      print('Result $result');

      expect(result, isA<List<CrewModel>>());
      expect(result.first.id, "1234");
      verify(
        mockClient.post(
          uri,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).called(1);
    });

    test('throws Exception if response statusCode != 200', () async {
      final uri = Uri.parse('https://api.spacexdata.com/v4/crew/query');

      when(
        mockClient.post(
          uri,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 500));

      expect(() => dataSource.fetchCrews(), throwsException);
      verify(
        mockClient.post(
          uri,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).called(1);
    });
  });
}
