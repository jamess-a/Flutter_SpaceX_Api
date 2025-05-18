import 'package:equatable/equatable.dart';

class LaunchPadDetail extends Equatable {
  final String id;
  final List<String> images;
  final String name;
  final String fullName;
  final String locality;
  final String region;
  final double latitude;
  final double longitude;
  final String timezone;
  final int launchAttempts;
  final int launchSuccesses;
  final String detail;
  final String status;

  const LaunchPadDetail({
    required this.id,
    required this.images,
    required this.name,
    required this.fullName,
    required this.locality,
    required this.region,
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.launchAttempts,
    required this.launchSuccesses,
    required this.detail,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    images,
    name,
    fullName,
    locality,
    region,
    latitude,
    longitude,
    timezone,
    launchAttempts,
    launchSuccesses,
    detail,
    status,
  ];
}
