import 'package:spacex/features/launches/domain/entities/launch.dart';

class LaunchModel extends Launch {
  LaunchModel({
    required String super.id,
    required super.name,
    required super.dateUtc,
    super.imageUrl,
    super.success,
    super.upcoming,
  });

  factory LaunchModel.fromJson(Map<String, dynamic> json) {
    return LaunchModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      dateUtc: DateTime.parse(json['date_utc']),
      imageUrl: json['links']?['patch']?['small'],
      success: json['success'],
      upcoming: json['upcoming'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date_utc': dateUtc.toIso8601String(),
      'links': {
        'patch': {'small': imageUrl},
      },
      'success': success,
      'upcoming': upcoming,
    };
  }

  Launch toEntity() => Launch(
    id: id,
    name: name,
    dateUtc: dateUtc,
    imageUrl: imageUrl,
    success: success,
    upcoming: upcoming,
  );
}
