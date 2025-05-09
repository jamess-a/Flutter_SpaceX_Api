import 'package:spacex/features/launches/domain/entities/launch_detail.dart';

class GetOneLaunchModel extends LaunchDetail {
  GetOneLaunchModel({
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

  factory GetOneLaunchModel.fromJson(Map<String, dynamic> json) {
    return GetOneLaunchModel(
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

  LaunchDetail toEntity() => LaunchDetail(
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
