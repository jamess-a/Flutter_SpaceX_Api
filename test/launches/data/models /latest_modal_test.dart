import 'package:flutter_test/flutter_test.dart';
import 'package:spacex/features/launches/data/models/latest_launch_model.dart';
import 'package:spacex/features/launches/domain/entities/latest_launch.dart';

void main() {
  final model = LatestLaunchModel(
    id: '321',
    name: 'Starship Launch',
    flightNumber: 42,
    dateUtc: DateTime.parse('2025-05-01T09:00:00Z'),
    patchImage: 'https://example.com/patch.png',
    webcastUrl: 'https://youtube.com',
    wikipediaUrl: 'https://en.wikipedia.org',
    success: true,
    crewIds: ['crew_1'],
    capsuleIds: ['capsule_1'],
    payloadIds: ['payload_1'],
    rocketId: 'rocket_1',
    launchpadId: 'launchpad_1',
    upcoming: false,
    imageUrl: 'https://example.com/patch.png',
    youtubeId: 'abc123',
  );

  final jsonMap = {
    'id': '321',
    'name': 'Starship Launch',
    'flight_number': 42,
    'date_utc': '2025-05-01T09:00:00.000Z',
    'links': {
      'patch': {'small': 'https://example.com/patch.png'},
      'webcast': 'https://youtube.com',
      'wikipedia': 'https://en.wikipedia.org',
      'youtube_id': 'abc123',
    },
    'success': true,
    'crew': ['crew_1'],
    'capsules': ['capsule_1'],
    'payloads': ['payload_1'],
    'rocket': 'rocket_1',
    'launchpad': 'launchpad_1',
    'upcoming': false,
    'image_url': 'https://example.com/patch.png',
  };

  test('fromJson should return valid model', () {
    final result = LatestLaunchModel.fromJson(jsonMap);
    print('result $result');
    expect(result, model);
  });

  test('toEntity should return LatestLaunch entity', () {
    final entity = model.toEntity();
    print('entity $entity');
    expect(entity, isA<LatestLaunch>());
    expect(entity.id, model.id);
  });
}
