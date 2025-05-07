// data/repositories/launch_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:spacex/core/error/failures.dart';
import 'package:spacex/features/launches/data/datasources/spacex_remote_data_source.dart';
import 'package:spacex/features/launches/domain/entities/launch.dart';
import 'package:spacex/features/launches/domain/repositories/launch_repository.dart';

class LaunchRepositoryImpl implements LaunchRepository {
  final LaunchRemoteDataSource remoteDataSource;

  LaunchRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Launch>>> getLaunches() async {
    try {
      final launches = await remoteDataSource.fetchUpcomingLaunches();
      return Right(launches);
    } catch (e) {
      return Left(ServerFailure('Exception: ${e.toString()}'));
    }
  }
}
