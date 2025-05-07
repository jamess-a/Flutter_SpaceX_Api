import 'package:dartz/dartz.dart';
import 'package:spacex/core/error/failures.dart';
import 'package:spacex/features/launches/data/datasources/spacex_remote_data_source.dart';
import 'package:spacex/features/launches/domain/entities/launch.dart';
import 'package:spacex/features/launches/domain/repositories/launch_repository.dart';

class LaunchRepositoryImpl implements LaunchRepository {
  final LaunchRemoteDataSource remoteDataSource;

  LaunchRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Launch>>> getLaunches({
    Map<String, dynamic>? query,
    Map<String, dynamic>? options,
  }) async {
    try {
      final models = await remoteDataSource.fetchLaunches(
        query: query,
        options: options,
      );
      final launches = models.map((m) => m.toEntity()).toList();
      return Right(launches);
    } catch (e) {
      return Left(ServerFailure('Exception: ${e.toString()}'));
    }
  }
}

