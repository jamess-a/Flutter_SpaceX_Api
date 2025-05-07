import 'package:spacex/features/launches/domain/entities/launch.dart';
import 'package:dartz/dartz.dart';
import 'package:spacex/core/error/failures.dart';

abstract class LaunchRepository {
  Future<Either<Failure, List<Launch>>> getLaunches({
    Map<String, dynamic>? query,
    Map<String, dynamic>? options,
  });
}
