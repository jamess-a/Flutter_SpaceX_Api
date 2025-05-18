import 'package:dartz/dartz.dart';
import 'package:spacex/core/error/failures.dart';
import 'package:spacex/features/launches/data/datasources/spacex_remote_data_source.dart';
import 'package:spacex/features/launches/domain/entities/crew_detail.dart';
import 'package:spacex/features/launches/domain/entities/latest_launch.dart';
import 'package:spacex/features/launches/domain/entities/launch.dart';
import 'package:spacex/features/launches/domain/entities/launch_detail.dart';
import 'package:spacex/features/launches/domain/entities/launchpad_detail.dart';
import 'package:spacex/features/launches/domain/entities/rocket_detail.dart';
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
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LatestLaunch>> getLatestLaunch() async {
    try {
      final model = await remoteDataSource.fetchLatestLaunch();
      final latestLaunch = model.toEntity();
      return Right(latestLaunch);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LaunchDetail>> getDetailLaunch(String id) async {
    try {
      final model = await remoteDataSource.fetchOneLaunch(id);
      final detailLaunch = model.toEntity();
      return Right(detailLaunch);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RocketDetail>> getDetailRocket(String id) async {
    try {
      final model = await remoteDataSource.fetchOneRocket(id);
      final detailRocket = model.toEntity();
      return Right(detailRocket);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CrewDetail>>> getDetailCrew(List<String> ids) async {
    try {
      final models = await remoteDataSource.fetchallCrews(ids);
      final detailCrews = models.map((m) => m.toEntity()).toList();
      return Right(detailCrews);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LaunchPadDetail>> getDetailLaunchPad(String id) async {
    try {
      final model = await remoteDataSource.fetchOneLaunchPad(id);
      final detailLaunchPad = model.toEntity();
      return Right(detailLaunchPad);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

}
