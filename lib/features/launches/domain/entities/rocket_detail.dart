import 'package:equatable/equatable.dart';

class RocketDetail extends Equatable {
  final String id;
  final String name;
  final String type;
  final bool active;
  final String firstFlight;
  final String country;
  final String company;
  final String image; 
  final String description;

  const RocketDetail({
    required this.id,
    required this.name,
    required this.type,
    required this.active,
    required this.firstFlight,
    required this.country,
    required this.company,
    required this.image,
    required this.description
  });

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        active,
        firstFlight,
        country,
        company,
        image,
        description
      ];
}
