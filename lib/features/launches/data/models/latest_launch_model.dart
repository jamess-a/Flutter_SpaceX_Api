import 'package:spacex/features/launches/domain/entities/latest_launch.dart';

class LatestLaunchModel extends LatestLaunch {
  LatestLaunchModel({
    required super.id,
    required super.name,
    required super.flightNumber,
    required super.dateUtc,
    required super.patchImage,
    required super.webcastUrl,
    required super.wikipediaUrl,
    required super.success,
    required super.crewIds,
    required super.capsuleIds,
    required super.payloadIds,
    required super.rocketId,
    required super.launchpadId,
    required super.upcoming,
    required super.imageUrl,
    required super.youtubeId,
  });

  factory LatestLaunchModel.fromJson(Map<String, dynamic> json) {
    return LatestLaunchModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      flightNumber: json['flight_number'] ?? 0,
      dateUtc: DateTime.parse(json['date_utc']),
      patchImage: json['links']?['patch']?['small'],
      webcastUrl: json['links']?['webcast'],
      wikipediaUrl: json['links']?['wikipedia'],
      success: json['success'] ?? false,
      crewIds: List<String>.from(json['crew'] ?? []),
      capsuleIds: List<String>.from(json['capsules'] ?? []),
      payloadIds: List<String>.from(json['payloads'] ?? []),
      rocketId: json['rocket'] ?? '',
      launchpadId: json['launchpad'] ?? '',
      upcoming: json['upcoming'] ?? false,
      imageUrl: json['links']?['patch']?['small'],
      youtubeId: json['links']?['youtube_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'flight_number': flightNumber,
      'date_utc': dateUtc.toIso8601String(),
      'links': {
        'patch': {'small': patchImage},
        'webcast': webcastUrl,
        'wikipedia': wikipediaUrl,
      },
      'success': success,
      'crew': crewIds,
      'capsules': capsuleIds,
      'payloads': payloadIds,
      'rocket': rocketId,
      'launchpad': launchpadId,
      'upcoming': upcoming,
      'image_url': imageUrl,
      'youtube_id': youtubeId,
    };
  }

  LatestLaunch toEntity() => LatestLaunch(
    id: id,
    name: name,
    flightNumber: flightNumber,
    dateUtc: dateUtc,
    patchImage: patchImage,
    webcastUrl: webcastUrl,
    wikipediaUrl: wikipediaUrl,
    success: success,
    crewIds: crewIds,
    capsuleIds: capsuleIds,
    payloadIds: payloadIds,
    rocketId: rocketId,
    launchpadId: launchpadId,
    upcoming: upcoming,
    imageUrl: imageUrl,
    youtubeId: youtubeId,
  );
}
