import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spacex/core/presentation/widgets/connectivity_wrapper.dart';
import 'package:spacex/core/presentation/widgets/custom_bottom_navbar.dart';
import 'package:spacex/core/theme/app_color.dart';
import 'package:spacex/features/crews/domain/usecase/crew_usecase.dart';
import 'package:spacex/features/launches/presentation/pages/launch_list_page.dart';
import 'package:spacex/features/crews/presentation/pages/crew_list_page.dart';
import 'package:spacex/core/di/injection_container.dart' as di;
import 'package:spacex/features/launches/domain/usecases/use_case.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          final currentRoute =
              GoRouter.of(context).routeInformationProvider.value.location;
          return Scaffold(
            body: ConnectivityWrapper(child: child),
            floatingActionButton: FloatingActionButton.large(
              backgroundColor:
                  currentRoute == '/all launches'
                      ? const Color.fromARGB(170, 255, 255, 255)
                      : AppColors.slateBlue,
              onPressed:
                  () => {
                    currentRoute == '/all launches'
                        ? null
                        : {
                          print('Go to all launches'),
                          // context.go('/all launches'),
                        },
                  },
              tooltip: 'All Launches',
              elevation: 4,
              shape: const CircleBorder(),
              child: const Icon(Icons.rocket, size: 64),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: CustomBottomNav(
              onCrewTap: () => context.push('/crew'),
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/home',
            builder:
                (context, state) => LaunchListScreen(
                  useCase: di.sl<GetLaunchListUseCase>(),
                  latestUseCase: di.sl<GetLatestLaunchUseCase>(),
                  detailUseCase: di.sl<GetDetailLaunchUseCase>(),
                ),
          ),
          GoRoute(
            path: '/crew',
            builder:
                (context, state) =>
                    CrewScreen(getCrewListUseCase: di.sl<GetCrewListUseCase>()),
          ),
        ],
      ),
    ],
  );
}
