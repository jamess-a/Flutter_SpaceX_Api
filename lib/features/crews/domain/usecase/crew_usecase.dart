import 'package:dartz/dartz.dart';
import 'package:spacex/core/error/failures.dart';
import 'package:spacex/features/crews/domain/entities/crew.dart';
import 'package:spacex/features/crews/domain/respositories/crew_repository.dart';

class GetCrewListUseCase {
  final CrewRepository repository;

  GetCrewListUseCase(this.repository);

  Future<Either<Failure, List<Crew>>> call({
    Map<String, dynamic>? query,
    Map<String, dynamic>? options,
  }) {
    return repository.getCrews(query: query, options: options);
  }
}
