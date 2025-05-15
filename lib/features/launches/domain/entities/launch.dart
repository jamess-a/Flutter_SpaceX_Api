import 'package:equatable/equatable.dart';

class Launch extends Equatable{
  final String? id;
  final String name;
  final DateTime dateUtc;
  final String? imageUrl;
  final bool? success;
  final bool? upcoming;

  Launch({
    required this.id,
    required this.name,
    required this.dateUtc,
    required this.imageUrl,
    required this.success,
    required this.upcoming
  });

  @override
  List<Object?> get props => [
    id,
    name,
    dateUtc,
    imageUrl,
    success,
    upcoming,
  ];
}
