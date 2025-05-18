import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:spacex/features/crews/data/datasources/crew_remote_data_source.dart';
import 'package:spacex/features/crews/data/respositories/crew_repository_impl.dart';
import 'package:spacex/features/crews/domain/respositories/crew_repository.dart';
import 'package:spacex/features/crews/domain/usecase/crew_usecase.dart';
import 'package:spacex/features/launches/data/datasources/spacex_remote_data_source.dart';
import 'package:spacex/features/launches/data/repositories/launch_repository_impl.dart';
import 'package:spacex/features/launches/domain/repositories/launch_repository.dart';
import 'package:spacex/features/launches/domain/usecases/use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final client = http.Client();

  // home pages (launches list)
  sl.registerLazySingleton(() => LaunchRemoteDataSource(client));
  sl.registerLazySingleton<LaunchRepository>(() => LaunchRepositoryImpl(sl()));

  // home pages use cases
  sl.registerLazySingleton(() => GetLaunchListUseCase(sl()));
  sl.registerLazySingleton(() => GetLatestLaunchUseCase(sl()));
  sl.registerLazySingleton(() => GetDetailLaunchUseCase(sl()));
  sl.registerLazySingleton(() => GetDetailRocketUseCase(sl()));
  sl.registerLazySingleton(() => GetCrewDetailUseCase(sl()));

  // crews list 
  sl.registerLazySingleton(()=> CrewsRemoteDataSource(client));
  sl.registerLazySingleton<CrewRepository>(() => CrewRepositoryImpl(sl()));

  // crew list use cases 
  sl.registerLazySingleton(() => GetCrewListUseCase(sl()));

  
}
