import 'package:spacex/features/launches/domain/entities/crew_detail.dart';

class DetailCrewModel extends CrewDetail  {
  DetailCrewModel({
    required super.id,
    required super.name,
    required super.agency,
    required super.imageUrl,
    required super.wikipediaUrl,
    required super.launches,
    required super.status,
  });

  factory DetailCrewModel.fromJson(Map<String, dynamic> json) {
    return DetailCrewModel(
      id: json['id'],
      name: json['name'],
      agency: json['agency'],
      imageUrl: json['image'],
      wikipediaUrl: json['wikipedia'],
      launches: List<String>.from(json['launches'] ?? []),
      status: json['status'],
    );
  }

  CrewDetail toEntity() => CrewDetail (
    id: id,
    name: name,
    agency: agency,
    imageUrl: imageUrl,
    wikipediaUrl: wikipediaUrl,
    launches: launches,
    status: status,
  );
}
