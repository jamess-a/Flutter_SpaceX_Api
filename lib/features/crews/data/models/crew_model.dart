import 'package:spacex/features/crews/domain/entities/crew.dart';

class CrewModel extends Crew {
  CrewModel({
    required super.id,
    required super.name,
    required super.agency,
    required super.imageUrl,
    required super.wikipediaUrl,
    required super.launches,
    required super.status,
  });


  factory CrewModel.fromJson(Map<String, dynamic> json) {
    return CrewModel(
      id: json['id'],
      name: json['name'],
      agency: json['agency'],
      imageUrl: json['image'],
      wikipediaUrl: json['wikipedia'],
      launches: List<String>.from(json['launches'] ?? []),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'agency': agency,
      'image': imageUrl,
      'wikipedia': wikipediaUrl,
      'launches': launches,
      'status': status,
    };
  }

  Crew toEntity() => Crew(
    id: id,
    name: name,
    agency: agency,
    imageUrl: imageUrl,
    wikipediaUrl: wikipediaUrl,
    launches: launches,
    status: status,
  );
}
