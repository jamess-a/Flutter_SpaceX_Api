import 'package:dartz/dartz.dart';
import 'package:spacex/core/error/failures.dart';
import 'package:spacex/features/crews/domain/entities/crew.dart';

abstract class CrewRepository {
  Future<Either<Failure , List<Crew>>> getCrews ({
    Map<String, dynamic>? query,
    Map<String, dynamic>? options,
  });
}