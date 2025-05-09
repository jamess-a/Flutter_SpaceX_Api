import 'package:spacex/features/launches/domain/entities/latest_launch.dart';
import 'package:spacex/features/launches/domain/entities/launch.dart';
import 'package:spacex/features/launches/domain/entities/launch_detail.dart';
import 'package:spacex/features/launches/domain/repositories/launch_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:spacex/core/error/failures.dart';

class GetLaunchListUseCase {
  final LaunchRepository repository;

  GetLaunchListUseCase(this.repository);

  Future<Either<Failure, List<Launch>>> call({
    Map<String, dynamic>? query,
    Map<String, dynamic>? options,
  }) {
    return repository.getLaunches(query: query, options: options);
  }
}

class GetLatestLaunchUseCase {
  final LaunchRepository repository;

  GetLatestLaunchUseCase(this.repository);

  Future<Either<Failure, LatestLaunch>> call() {
    return repository.getLatestLaunch();
  }
}

class GetDetailLaunchUseCase {
  final LaunchRepository repository;

  GetDetailLaunchUseCase(this.repository);

  Future<Either<Failure, LaunchDetail>> call(String id) {
    return repository.getDetailLaunch(id);
  }
}
