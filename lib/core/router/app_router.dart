import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spacex/core/presentation/widgets/connectivity_wrapper.dart';
import 'package:spacex/core/presentation/widgets/custom_bottom_navbar.dart';
import 'package:spacex/core/theme/app_color.dart';
import 'package:spacex/core/utils/notifications_helper.dart';
import 'package:spacex/features/crews/domain/usecase/crew_usecase.dart';
import 'package:spacex/features/launches/presentation/pages/launch_list_page.dart';
import 'package:spacex/features/crews/presentation/pages/crew_list_page.dart';
import 'package:spacex/core/di/injection_container.dart' as di;
import 'package:spacex/features/launches/domain/usecases/use_case.dart';
import 'package:spacex/localization/localization_cubit.dart';
import 'package:spacex/localization/strings_en.i69n.dart';

class AppRouter {
  static void switchLanguage(BuildContext context) {
    context.read<LanguageCubit>().toggleLanguage();

    final strings = context.read<LanguageCubit>().state;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationHelper.showSuccess(
        context,
        "Switched language to ${strings is Strings_en ? 'TH' : 'EN'}",
      );
    });
  }

  static final router = GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          final currentRoute = state.fullPath ?? '';
          final strings = context.watch<LanguageCubit>().state;
          return 
          Scaffold(
            appBar: AppBar(
              title: Text('Space X'),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextButton(
                    onPressed: () => switchLanguage(context),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.slateBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.language, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          strings is Strings_en ? 'EN' : 'TH',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
              currentRoute: currentRoute,
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
                  rockdetailUseCase: di.sl<GetDetailRocketUseCase>()
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
