import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spacex/core/presentation/widgets/connectivity_wrapper.dart';
import 'package:spacex/core/presentation/widgets/custom_bottom_navbar.dart';
import 'package:spacex/core/theme/app_color.dart';
import 'package:spacex/features/launches/presentation/pages/launch_list_page.dart';
import 'package:spacex/features/crew/presentation/pages/crew_list_page.dart';
import 'package:spacex/core/di/injection_container.dart' as di;
import 'package:spacex/features/launches/domain/usecases/use_case.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: ConnectivityWrapper(child: child),
            floatingActionButton: FloatingActionButton.large(
              backgroundColor: AppColors.slateBlue,
              onPressed: () => context.push('/profile'),
              tooltip: 'Profile',
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
            builder: (context, state) => const CrewScreen(),
          ),
        ],
      ),
    ],
  );
}
