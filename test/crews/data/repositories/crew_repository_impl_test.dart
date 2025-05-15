import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spacex/core/error/failures.dart';
import 'package:spacex/features/crews/data/models/crew_model.dart';
import 'package:spacex/features/crews/data/respositories/crew_repository_impl.dart';

import '../../../helpers/mock_helper.mocks.dart';

void main() {
  late CrewRepositoryImpl repository;
  late MockCrewsRemoteDataSource mockCrewsRemoteDataSource;

  setUp(() {
    mockCrewsRemoteDataSource = MockCrewsRemoteDataSource();
    repository = CrewRepositoryImpl(mockCrewsRemoteDataSource);
  });

  group('CrewRepositoryImpl Tests', () {
    group('getCrews', () {
      final mockModel = CrewModel(
        id: '123',
        name: 'Test',
        agency: 'NASA',
        imageUrl: 'https://example.com/image.png',
        wikipediaUrl: 'https://en.wikipedia.org/wiki/test',
        launches: ['1234'],
        status: 'active',
      );

      final mockEntity = mockModel.toEntity();

      test('return Right(List<Crew>) on success', () async {
        when(
          mockCrewsRemoteDataSource.fetchCrews(query: null, options: null),
        ).thenAnswer((_) async => [mockModel]);
        final result = await repository.getCrews();

        expect(result.isRight(), true);
        expect(result.getOrElse(() => []), equals([mockEntity]));

        print('impl $result');

        verify(
          mockCrewsRemoteDataSource.fetchCrews(query: null, options: null),
        ).called(1);
      });

      test('returns Left(ServerFailure) on exception', () async {
        when(
          mockCrewsRemoteDataSource.fetchCrews(query: null, options: null),
        ).thenThrow('API Failed');

        final result = await repository.getCrews();
        print('impl $result');

        expect(result, Left(ServerFailure('API Failed')));
      });
    });
  });
}
