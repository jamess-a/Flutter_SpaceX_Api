import 'package:spacex/features/launches/domain/entities/crew_detail.dart';
import 'package:spacex/features/launches/domain/entities/latest_launch.dart';
import 'package:spacex/features/launches/domain/entities/launch.dart';
import 'package:spacex/features/launches/domain/entities/launch_detail.dart';
import 'package:spacex/features/launches/domain/entities/launchpad_detail.dart';
import 'package:spacex/features/launches/domain/entities/rocket_detail.dart';
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

class GetDetailRocketUseCase {
  final LaunchRepository repository;

  GetDetailRocketUseCase(this.repository);

  Future<Either<Failure, RocketDetail>> call(String id) {
    return repository.getDetailRocket(id);
  }
}

class GetCrewDetailUseCase {
  final LaunchRepository repository;

  GetCrewDetailUseCase(this.repository);

  Future<Either<Failure, List<CrewDetail>>> call(List<String> ids) {
    return repository.getDetailCrew(ids);
  }
}

class GetDetailLaunchPadUseCase {
  final LaunchRepository repository;

  GetDetailLaunchPadUseCase(this.repository);

  Future<Either<Failure, LaunchPadDetail>> call(String id) {
    return repository.getDetailLaunchPad(id);
  }
}
