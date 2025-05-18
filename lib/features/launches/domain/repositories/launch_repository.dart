import 'package:spacex/features/launches/domain/entities/crew_detail.dart';
import 'package:spacex/features/launches/domain/entities/latest_launch.dart';
import 'package:spacex/features/launches/domain/entities/launch.dart';
import 'package:spacex/features/launches/domain/entities/launch_detail.dart';
import 'package:spacex/features/launches/domain/entities/rocket_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:spacex/core/error/failures.dart';

abstract class LaunchRepository {
  Future<Either<Failure, List<Launch>>> getLaunches({
    Map<String, dynamic>? query,
    Map<String, dynamic>? options,
  });

  Future<Either<Failure, LatestLaunch>> getLatestLaunch();
  Future<Either<Failure, LaunchDetail>> getDetailLaunch(String id);
  Future<Either<Failure, RocketDetail>> getDetailRocket(String id);
  Future<Either<Failure, List<CrewDetail>>> getDetailCrew(List<String> ids);
}
