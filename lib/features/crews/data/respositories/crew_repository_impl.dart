import 'package:dartz/dartz.dart';
import 'package:spacex/core/error/failures.dart';
import 'package:spacex/features/crews/data/datasources/crew_remote_data_source.dart';
import 'package:spacex/features/crews/domain/entities/crew.dart';
import 'package:spacex/features/crews/domain/respositories/crew_repository.dart';

class CrewRepositoryImpl implements CrewRepository {
  final CrewsRemoteDataSource remoteDataSource;

  CrewRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Crew>>> getCrews({
    Map<String, dynamic>? query,
    Map<String, dynamic>? options,
  }) async {
    try {
      final models = await remoteDataSource.fetchCrews(
        query: query,
        options: options,
      );
      final crews = models.map((m) => m.toEntity()).toList();
      return Right(crews);
    } catch (e) {
      print(e);
      return Left(ServerFailure(e.toString()));
    }
  }
}
