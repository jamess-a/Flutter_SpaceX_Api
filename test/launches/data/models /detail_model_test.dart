import 'package:flutter_test/flutter_test.dart';
import 'package:spacex/features/launches/data/models/detail_launch_model.dart';
import 'package:spacex/features/launches/domain/entities/launch_detail.dart';

void main() {
  final model = DetailLaunchModel(
    id: '456',
    name: 'Crew-8',
    flightNumber: 99,
    dateUtc: DateTime.parse('2023-08-15T15:30:00Z'),
    patchImage: 'https://example.com/patch.png',
    webcastUrl: 'https://youtube.com/crew8',
    wikipediaUrl: 'https://en.wikipedia.org/wiki/Crew-8',
    success: true,
    crewIds: ['crew_8'],
    capsuleIds: ['capsule_8'],
    payloadIds: ['payload_8'],
    rocketId: 'rocket_8',
    launchpadId: 'launchpad_8',
    upcoming: false,
    imageUrl: 'https://example.com/patch.png',
    youtubeId: 'yt123',
    detail: 'Mission to the ISS',
  );

  final jsonMap = {
    'id': '456',
    'name': 'Crew-8',
    'flight_number': 99,
    'date_utc': '2023-08-15T15:30:00.000Z',
    'links': {
      'patch': {'small': 'https://example.com/patch.png'},
      'webcast': 'https://youtube.com/crew8',
      'wikipedia': 'https://en.wikipedia.org/wiki/Crew-8',
      'youtube_id': 'yt123',
    },
    'success': true,
    'crew': ['crew_8'],
    'capsules': ['capsule_8'],
    'payloads': ['payload_8'],
    'rocket': 'rocket_8',
    'launchpad': 'launchpad_8',
    'upcoming': false,
    'image_url': 'https://example.com/patch.png',
    'details': 'Mission to the ISS',
  };

  test('fromJson should return valid model', () {
    final result = DetailLaunchModel.fromJson(jsonMap);
    print('result $result');
    expect(result, model);
  });

  test('toEntity should return LaunchDetail entity', () {
    final entity = model.toEntity();
    print('entity $entity');
    expect(entity, isA<LaunchDetail>());
    expect(entity.name, model.name);
  });
}
