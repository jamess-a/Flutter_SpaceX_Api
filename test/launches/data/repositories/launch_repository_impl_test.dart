import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:spacex/core/error/failures.dart';
import 'package:spacex/features/launches/data/repositories/launch_repository_impl.dart';
import 'package:spacex/features/launches/data/models/launch_model.dart';
import 'package:spacex/features/launches/data/models/latest_launch_model.dart';
import 'package:spacex/features/launches/data/models/detail_launch_model.dart';

import '../../../helpers/mock_helper.mocks.dart';

void main() {
  late LaunchRepositoryImpl repository;
  late MockLaunchRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockLaunchRemoteDataSource();
    repository = LaunchRepositoryImpl(mockRemoteDataSource);
  });

  group('LaunchRepositoryImpl Tests', () {
    group('getLaunches', () {
      final mockModel = LaunchModel(
        id: '1',
        name: 'Falcon 9',
        dateUtc: DateTime.parse('2023-04-01T00:00:00Z'),
        imageUrl: 'https://example.com/image1.jpg',
        success: true,
        upcoming: false,
      );

      final mockEntity = mockModel.toEntity();

      test('returns Right(List<Launch>) on success', () async {
        when(
          mockRemoteDataSource.fetchLaunches(query: null, options: null),
        ).thenAnswer((_) async => [mockModel]);

        final result = await repository.getLaunches();

        debugPrint('Result: $result');

        expect(result.isRight(), true);
        expect(result.getOrElse(() => []), equals([mockEntity]));

        verify(
          mockRemoteDataSource.fetchLaunches(query: null, options: null),
        ).called(1);
      });

      test('returns Left(ServerFailure) on exception', () async {
        when(
          mockRemoteDataSource.fetchLaunches(query: null, options: null),
        ).thenThrow(('API failed'));

        final result = await repository.getLaunches();
        debugPrint('Result: $result');

        expect(result, Left(ServerFailure('API failed')));
      });
    });

    group('getLatestLaunch', () {
      final mockModel = LatestLaunchModel(
        id: '2',
        name: 'Falcon Heavy',
        flightNumber: 42,
        dateUtc: DateTime.parse('2023-05-01T00:00:00Z'),
        patchImage: null,
        webcastUrl: null,
        wikipediaUrl: null,
        success: true,
        crewIds: [],
        capsuleIds: [],
        payloadIds: [],
        rocketId: 'rocketId',
        launchpadId: 'launchpadId',
        upcoming: false,
        imageUrl: 'https://example.com/img.jpg',
        youtubeId: 'abc123',
      );

      final mockEntity = mockModel.toEntity();

      test('returns Right(LatestLaunch) on success', () async {
        when(
          mockRemoteDataSource.fetchLatestLaunch(),
        ).thenAnswer((_) async => mockModel);

        final result = await repository.getLatestLaunch();
        debugPrint('Result: $result');

        expect(result, Right(mockEntity));

        verify(mockRemoteDataSource.fetchLatestLaunch()).called(1);
      });

      test('returns Left(ServerFailure) on exception', () async {
        when(mockRemoteDataSource.fetchLatestLaunch()).thenThrow(('API down'));

        final result = await repository.getLatestLaunch();
        debugPrint('Result: $result');

        expect(result, Left(ServerFailure('API down')));
      });
    });

    group('getDetailLaunch', () {
      const launchId = 'abc123';

      final mockModel = DetailLaunchModel(
        id: launchId,
        name: 'Falcon 9',
        flightNumber: 99,
        dateUtc: DateTime.parse('2024-01-01T00:00:00Z'),
        patchImage: null,
        webcastUrl: null,
        wikipediaUrl: null,
        success: true,
        crewIds: [],
        capsuleIds: [],
        payloadIds: [],
        rocketId: 'rocketId',
        launchpadId: 'launchpadId',
        upcoming: false,
        imageUrl: 'https://example.com/img.jpg',
        youtubeId: 'xyz789',
        detail: 'Test detail launch',
      );

      final mockEntity = mockModel.toEntity();

      test('returns Right(LaunchDetail) on success', () async {
        when(
          mockRemoteDataSource.fetchOneLaunch(launchId),
        ).thenAnswer((_) async => mockModel);

        final result = await repository.getDetailLaunch(launchId);
        debugPrint('Result: $result');
        expect(result, Right(mockEntity));
        verify(mockRemoteDataSource.fetchOneLaunch(launchId)).called(1);
      });

      test('returns Left(ServerFailure) on exception', () async {
        when(
          mockRemoteDataSource.fetchOneLaunch(launchId),
        ).thenThrow(('No launch'));

        final result = await repository.getDetailLaunch(launchId);
        debugPrint('Result: $result');

        expect(result, Left(ServerFailure('No launch')));
      });
    });
  });
}
