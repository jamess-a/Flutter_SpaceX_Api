import 'package:equatable/equatable.dart';

class CrewDetail extends Equatable {
  final String id;
  final String name;
  final String agency;
  final String imageUrl;
  final String? wikipediaUrl;
  final List<String> launches;
  final String status;

  const CrewDetail({
    required this.id,
    required this.name,
    required this.agency,
    required this.imageUrl,
    required this.wikipediaUrl,
    required this.launches,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    agency,
    imageUrl,
    wikipediaUrl,
    launches,
    status,
  ];
}
