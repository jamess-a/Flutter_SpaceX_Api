import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:spacex/core/constants/keys.dart';
import 'package:spacex/features/launches/data/datasources/spacex_remote_data_source.dart';
import 'package:spacex/features/launches/data/repositories/launch_repository_impl.dart';
import 'package:spacex/features/launches/domain/usecases/get_launch_list_use_case.dart';
import 'package:spacex/features/launches/presentation/bloc/launch_list_bloc.dart';
import 'package:spacex/features/launches/presentation/bloc/launch_list_event.dart';
import 'package:spacex/features/launches/presentation/pages/launch_list_page.dart';
import 'package:spacex/localization/localization_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final client = http.Client();
  final repository = LaunchRepositoryImpl(LaunchRemoteDataSource(client));
  final useCase = GetLaunchListUseCase(repository);

  runApp(MyApp(useCase: useCase));
}

class MyApp extends StatelessWidget {
  final GetLaunchListUseCase useCase;

  const MyApp({super.key, required this.useCase});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(create: (_) => LanguageCubit()),
        BlocProvider<LaunchListBloc>(
          create: (_) => LaunchListBloc(useCase)..add(FetchLaunches()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            theme: ThemeData.dark(),
            home: LaunchListScreen(useCase: useCase),
          );
        },
      ),
    );
  }
}
