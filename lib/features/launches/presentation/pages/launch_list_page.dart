import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/core/theme/app_color.dart';
import 'package:spacex/core/utils/dateformator.dart';
import 'package:spacex/core/utils/notifications_helper.dart';
import 'package:spacex/features/launches/domain/entities/crew_detail.dart';
import 'package:spacex/features/launches/domain/entities/rocket_detail.dart';
import 'package:spacex/features/launches/domain/usecases/use_case.dart';
import 'package:spacex/features/launches/presentation/bloc/latest_launch/latest_launch_list_bloc.dart';
import 'package:spacex/features/launches/presentation/bloc/latest_launch/latest_launch_list_event.dart';
import 'package:spacex/features/launches/presentation/bloc/latest_launch/latest_launch_list_state.dart';
import 'package:spacex/features/launches/presentation/bloc/launch_detail/detail_launch_list_bloc.dart';
import 'package:spacex/features/launches/presentation/bloc/launch_detail/detail_launch_list_event.dart';
import 'package:spacex/features/launches/presentation/bloc/launches/launch_list_bloc.dart';
import 'package:spacex/features/launches/presentation/bloc/launches/launch_list_event.dart';
import 'package:spacex/features/launches/presentation/bloc/launches/launch_list_state.dart';
import 'package:spacex/features/launches/presentation/pages/widgets/detail_launch_modal_widget.dart';
import 'package:spacex/features/launches/presentation/pages/widgets/search_launch_widget.dart';
import 'package:spacex/features/launches/presentation/pages/widgets/live_launch_widget.dart';

import 'package:spacex/localization/localization_cubit.dart';
import 'package:spacex/localization/generated/strings_en.i69n.dart';

class LaunchListScreen extends StatelessWidget {
  final GetLaunchListUseCase useCase;
  final GetLatestLaunchUseCase latestUseCase;
  final GetDetailLaunchUseCase detailUseCase;
  final GetDetailRocketUseCase rockdetailUseCase;
  final GetCrewDetailUseCase crewsdetailUseCase;
  const LaunchListScreen({
    super.key,
    required this.useCase,
    required this.latestUseCase,
    required this.detailUseCase,
    required this.rockdetailUseCase,
    required this.crewsdetailUseCase,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.watch<LanguageCubit>().state;
    final height = MediaQuery.of(context).size.height;

    void switchLanguage(BuildContext context) {
      final strings = context.read<LanguageCubit>().state;
      context.read<LanguageCubit>().toggleLanguage();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        NotificationHelper.showSuccess(
          context,
          "Switched language to ${strings is Strings_en ? 'TH' : 'EN'}",
        );
      });
    }

    void handleOpenModal(BuildContext context, String id) async {
      final launchBloc = context.read<DetailLaunchBloc>();
      final navigator = Navigator.of(context, rootNavigator: true);
      final language = context.read<LanguageCubit>().state;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      try {
        final launchResult = await detailUseCase.call(id);
        print(launchResult);

        await launchResult.fold(
          (failure) {
            NotificationHelper.showError(
              context,
              failure.message ?? 'no message',
            );
          },
          (launch) async {
            RocketDetail? rocket;
            final rocketId = launch.rocketId;
            if (rocketId.isNotEmpty) {
              final rocketResult = await rockdetailUseCase.call(rocketId);
              rocketResult.fold((rocketFailure) {
                NotificationHelper.showError(
                  context,
                  rocketFailure.message ?? 'Rocket info unavailable',
                );
              }, (r) => rocket = r);
            }

            List<CrewDetail> crews = [];
            final crewId = launch.crewIds;
            if (crews.isEmpty || crews.every((c) => c == null)) {
              final crewResult = await crewsdetailUseCase.call(crewId);
              crewResult.fold((crewFailure) {
                NotificationHelper.showError(
                  context,
                  crewFailure.message ?? 'Crew info unavailable',
                );
              }, (c) => crews = c);
            }

            launchBloc.add(FetchDetailLaunch(id));
            showLaunchModalBottomSheet(
              context,
              launch,
              rocket!,
              crews,
              language,
            );
          },
        );
      } catch (e) {
        NotificationHelper.showError(context, 'Unexpected error occurred: $e');
      } finally {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (navigator.canPop()) {
            navigator.pop();
          }
        });
      }
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<LatestLaunchBloc>(
          create:
              (_) =>
                  LatestLaunchBloc(latestUseCase.call)
                    ..add(FetchLatestLaunch()),
        ),
        BlocProvider<LaunchListBloc>(
          create: (_) => LaunchListBloc(useCase.call)..add(FetchLaunches()),
        ),
        BlocProvider<DetailLaunchBloc>(
          create: (_) => DetailLaunchBloc(detailUseCase.call),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: [
                Builder(
                  builder: (context) => SearchLaunchWidget(string: strings),
                ),
                Expanded(
                  child: BlocBuilder<LaunchListBloc, LaunchListState>(
                    builder: (context, state) {
                      if (state is LaunchListLoading) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          NotificationHelper.showSuccess(
                            context,
                            "${strings.launches.loading}",
                          );
                        });
                        return Center(
                          child: SizedBox(
                            height: height / 2,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        );
                      } else if (state is LaunchListLoaded) {
                        if (state.launches.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.search_off,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  strings.launches.emptyResult,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return RefreshIndicator(
                          onRefresh: () async {
                            context.read<LaunchListBloc>().add(FetchLaunches());
                          },
                          child: SizedBox(
                            height: height / 2,
                            child: Scrollbar(
                              thumbVisibility: true,
                              trackVisibility: true,
                              child: ListView.builder(
                                itemCount: state.launches.length.clamp(0, 40),
                                itemBuilder: (context, index) {
                                  final launch = state.launches[index];
                                  return Card(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 4,
                                    child: ListTile(
                                      title: Text(
                                        launch.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        DateTimeFormatter.formatDateTime(
                                          launch.dateUtc,
                                        ),
                                      ),
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child:
                                            launch.imageUrl != null
                                                ? Image.network(
                                                  launch.imageUrl!,
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) => const Icon(
                                                        Icons.broken_image,
                                                      ),
                                                )
                                                : const Icon(
                                                  Icons.image_not_supported,
                                                ),
                                      ),
                                      trailing: SizedBox(
                                        width: 60,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            if (launch.upcoming == true) ...[
                                              const Icon(
                                                Icons.schedule,
                                                color: Colors.orange,
                                              ),
                                            ] else ...[
                                              const Icon(
                                                Icons.rocket_launch_rounded,
                                                color: Colors.green,
                                              ),
                                              const SizedBox(width: 4),
                                              launch.success == true
                                                  ? const Icon(
                                                    Icons.check_outlined,
                                                    color: Colors.green,
                                                  )
                                                  : const Icon(
                                                    Icons.warning_rounded,
                                                    color: Colors.red,
                                                  ),
                                            ],
                                          ],
                                        ),
                                      ),

                                      onTap: () {
                                        if (launch.id == null) {
                                          return print('null id');
                                        }
                                        handleOpenModal(
                                          context,
                                          launch.id ?? '',
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      } else if (state is LaunchListError) {
                        return Center(child: Text(state.message));
                      } else {
                        return Text(strings.launches.error);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BlocBuilder<LatestLaunchBloc, LatestLaunchState>(
                    builder: (context, state) {
                      if (state is LatestLaunchLoaded && state.launch != null) {
                        return LiveLaunch(
                          string: strings,
                          launch: state.launch!,
                        );
                      } else if (state is LatestLaunchLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is LatestLaunchError) {
                        print(state.message);
                        return Center(child: Text(state.message));
                      } else {
                        return Text(strings.launches.error);
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
