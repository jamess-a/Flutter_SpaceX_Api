import 'package:spacex/features/launches/domain/entities/latest_launch.dart';
import 'package:spacex/features/launches/domain/entities/launch.dart';
import 'package:dartz/dartz.dart';
import 'package:spacex/core/error/failures.dart';
import 'package:spacex/features/launches/domain/entities/launch_detail.dart';

abstract class LaunchRepository {
  Future<Either<Failure, List<Launch>>> getLaunches({
    Map<String, dynamic>? query,
    Map<String, dynamic>? options,
  });

  Future<Either<Failure, LatestLaunch>> getLatestLaunch();
  Future<Either<Failure, LaunchDetail>> getDetailLaunch(
    String id,  
  );
}
