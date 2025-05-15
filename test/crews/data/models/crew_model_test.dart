import 'package:flutter_test/flutter_test.dart';
import 'package:spacex/features/crews/data/models/crew_model.dart';
import 'package:spacex/features/crews/domain/entities/crew.dart';

void main() {
  final model = CrewModel(
    id: '123',
    name: 'Test',
    agency: 'NASA',
    imageUrl: 'https://example.com/image.png',
    wikipediaUrl: 'https://en.wikipedia.org/wiki/test',
    launches: ['1234'],
    status: 'active',
  );

  final jsonMap = {
    'id': '123',
    'name': 'Test',
    'agency': 'NASA',
    'image': 'https://example.com/image.png',
    'wikipedia': 'https://en.wikipedia.org/wiki/test',
    'launches': ['1234'],
    'status': 'active',
  };

  test('fromJson should return vilid crew model', () {
    final result = CrewModel.fromJson(jsonMap);
    print('result $result');
    expect(result, model);
  });

  test('toEntity should return Crew entity', () {
    final entity = model.toEntity();
    print('entity $entity');
    expect(entity, isA<Crew>());
    expect(entity.id, model.id);
  });
}
