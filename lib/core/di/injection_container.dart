import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:spacex/features/launches/data/datasources/spacex_remote_data_source.dart';
import 'package:spacex/features/launches/data/repositories/launch_repository_impl.dart';
import 'package:spacex/features/launches/domain/repositories/launch_repository.dart';
import 'package:spacex/features/launches/domain/usecases/use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final client = http.Client();
  sl.registerLazySingleton(() => LaunchRemoteDataSource(client));
  sl.registerLazySingleton<LaunchRepository>(() => LaunchRepositoryImpl(sl()));

  // use cases
  sl.registerLazySingleton(() => GetLaunchListUseCase(sl()));
  sl.registerLazySingleton(() => GetLatestLaunchUseCase(sl()));
  sl.registerLazySingleton(() => GetDetailLaunchUseCase(sl()));
}
