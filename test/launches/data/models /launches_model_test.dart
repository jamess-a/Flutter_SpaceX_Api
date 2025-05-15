import 'package:flutter_test/flutter_test.dart';
import 'package:spacex/features/launches/data/models/launch_model.dart';
import 'package:spacex/features/launches/domain/entities/launch.dart';

void main() {
  final model = LaunchModel(
    id: '123',
    name: 'Falcon 9',
    dateUtc: DateTime.parse('2024-01-01T12:00:00.000Z'),
    imageUrl: 'https://example.com/image.png',
    success: true,
    upcoming: false,
  );

  final jsonMap = {
    'id': '123',
    'name': 'Falcon 9',
    'date_utc': '2024-01-01T12:00:00.000Z',
    'links': {
      'patch': {'small': 'https://example.com/image.png'}
    },
    'success': true,
    'upcoming': false,
  };

  test('fromJson should return valid model', () {
    final result = LaunchModel.fromJson(jsonMap);
    print('result $result');
    expect(result, model);
  });

  test('toEntity should return Launch entity', () {
    final entity = model.toEntity();
    print('entity $entity');
    expect(entity, isA<Launch>());
    expect(entity.id, model.id);
  });
}
