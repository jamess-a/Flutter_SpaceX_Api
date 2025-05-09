import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:spacex/core/constants/keys.dart';
import 'package:spacex/features/launches/data/datasources/spacex_remote_data_source.dart';
import 'package:spacex/features/launches/data/repositories/launch_repository_impl.dart';
import 'package:spacex/features/launches/domain/usecases/use_case.dart';
import 'package:spacex/features/launches/presentation/pages/launch_list_page.dart';
import 'package:spacex/localization/localization_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final client = http.Client();
  final repository = LaunchRepositoryImpl(LaunchRemoteDataSource(client));
  final useCase = GetLaunchListUseCase(repository);
  final latestUseCase = GetLatestLaunchUseCase(repository);
  final detailUseCase = GetDetailLaunchUseCase(repository);

  runApp(
    MyApp(
      useCase: useCase,
      latestUseCase: latestUseCase,
      detailUseCase: detailUseCase,
    ),
  );
}

class MyApp extends StatelessWidget {
  final GetLaunchListUseCase useCase;
  final GetLatestLaunchUseCase latestUseCase;
  final GetDetailLaunchUseCase detailUseCase;

  const MyApp({
    super.key,
    required this.useCase,
    required this.latestUseCase,
    required this.detailUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<LanguageCubit>(create: (_) => LanguageCubit())],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            theme: ThemeData.dark(),
            home: LaunchListScreen(
              useCase: useCase,
              latestUseCase: latestUseCase,
              detailUseCase: detailUseCase,
            ),
          );
        },
      ),
    );
  }
}
