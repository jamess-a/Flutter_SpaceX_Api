import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spacex/features/crews/domain/entities/crew.dart';

import '../../../helpers/mock_helper.mocks.dart';

void main() {
  late MockCrewRepository mockCrewRepository;

  setUp(() {
    mockCrewRepository = MockCrewRepository();
  });

  test('should return a list of crews when getCrews is successful', () async {
    final mockCrews = [
      Crew(
        id: '1',
        name: 'test1',
        agency: 'NASA',
        imageUrl: 'https://example.com/image1.jpg',
        launches: ['123f2'],
        status: 'active',
        wikipediaUrl: 'https://en.wikipedia.org/wiki/test',
      ),
    ];

    when(
      mockCrewRepository.getCrews(),
    ).thenAnswer((_) async => Right(mockCrews));

    final result = await mockCrewRepository.getCrews();
    print('data mock $result');
    expect(result, Right(mockCrews));
    verify(mockCrewRepository.getCrews()).called(1);
  });
}
