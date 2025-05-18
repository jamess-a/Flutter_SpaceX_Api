import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/core/di/injection_container.dart' as di;
import 'package:spacex/core/network/connectivity_cubit.dart';
import 'package:spacex/core/router/app_router.dart';
import 'package:spacex/localization/localization_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) => null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(create: (_) => LanguageCubit()),
        BlocProvider<ConnectivityCubit>(create: (_) => ConnectivityCubit()),
      ],
      child: Builder(
        builder:
            (context) => MaterialApp.router(
              routerConfig: AppRouter.router,
              theme: ThemeData.dark(),
            ),
      ),
    );
  }
}
