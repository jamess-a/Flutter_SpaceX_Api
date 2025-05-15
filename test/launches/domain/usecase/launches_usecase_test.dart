import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spacex/features/launches/domain/repositories/launch_repository.dart';
import 'package:spacex/features/launches/domain/entities/launch.dart';
import 'package:spacex/core/error/failures.dart';
import 'package:spacex/features/launches/domain/entities/latest_launch.dart';
import 'package:spacex/features/launches/domain/entities/launch_detail.dart';

import '../../../helpers/mock_helper.mocks.dart';

void main() {
  late MockLaunchRepository mockRepository;

  setUp(() {
    mockRepository = MockLaunchRepository();
  });

  test(
    'should return a list of launches when getLaunches is successful',
    () async {
      final mockLaunches = [
        Launch(
          id: '1',
          name: 'Falcon 9',
          dateUtc: DateTime.parse('2023-04-01T00:00:00Z'),
          imageUrl: 'https://example.com/image1.jpg',
          success: true,
          upcoming: false,
        ),
      ];

      when(
        mockRepository.getLaunches(),
      ).thenAnswer((_) async => Right(mockLaunches));

      final result = await mockRepository.getLaunches();
      print('data mock $result');
      expect(result, Right(mockLaunches));
      verify(mockRepository.getLaunches()).called(1);
    },
  );

  test(
    'should return the latest launch when getLatestLaunch is successful',
    () async {
      final mockLatestLaunch = LatestLaunch(
        id: '2',
        name: 'Falcon Heavy',
        flightNumber: 1,
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
        upcoming: true,
        imageUrl: 'https://example.com/image.jpg',
        youtubeId: null,
      );

      when(
        mockRepository.getLatestLaunch(),
      ).thenAnswer((_) async => Right(mockLatestLaunch));

      final result = await mockRepository.getLatestLaunch();
      print('data mock $result');
      expect(result, Right(mockLatestLaunch));
      verify(mockRepository.getLatestLaunch()).called(1);
    },
  );

  test(
    'should return the launch detail when getDetailLaunch is successful',
    () async {
      final mockLaunchDetail = LaunchDetail(
        id: '1',
        name: 'Falcon 9',
        flightNumber: 1,
        dateUtc: DateTime.parse('2023-04-01T00:00:00Z'),
        patchImage: null,
        webcastUrl: null,
        wikipediaUrl: null,
        success: true,
        crewIds: [],
        capsuleIds: [],
        payloadIds: [],
        rocketId: 'rocketId',
        launchpadId: 'launchpadId',
        upcoming: true,
        imageUrl: 'https://example.com/image.jpg',
        youtubeId: null,
        detail: 'This is a detailed description of the launch',
      );

      when(
        mockRepository.getDetailLaunch(any),
      ).thenAnswer((_) async => Right(mockLaunchDetail));

      final result = await mockRepository.getDetailLaunch('1');
      print('data mock $result');
      expect(result, Right(mockLaunchDetail));
      verify(mockRepository.getDetailLaunch('1')).called(1);
    },
  );
}
