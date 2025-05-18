import 'package:spacex/features/launches/domain/entities/launchpad_detail.dart';

class DetailLaunchpadModel extends LaunchPadDetail {
  DetailLaunchpadModel({
    required super.id,
    required super.images,
    required super.name,
    required super.fullName,
    required super.locality,
    required super.region,
    required super.latitude,
    required super.longitude,
    required super.timezone,
    required super.launchAttempts,
    required super.launchSuccesses,
    required super.detail,
    required super.status,
  });

  factory DetailLaunchpadModel.fromJson(Map<String, dynamic> json) {
    return DetailLaunchpadModel(
      id: json['id'],
      images: List<String>.from(json['images']?['large'] ?? []),
      name: json['name'],
      fullName: json['full_name'],
      locality: json['locality'],
      region: json['region'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      timezone: json['timezone'],
      launchAttempts: json['launch_attempts'],
      launchSuccesses: json['launch_successes'],
      detail: json['details'],
      status: json['status'],
    );
  }

  LaunchPadDetail toEntity() => LaunchPadDetail(
        id: id,
        images: images,
        name: name,
        fullName: fullName,
        locality: locality,
        region: region,
        latitude: latitude,
        longitude: longitude,
        timezone: timezone,
        launchAttempts: launchAttempts,
        launchSuccesses: launchSuccesses,
        detail: detail,
        status: status,
      );
}
