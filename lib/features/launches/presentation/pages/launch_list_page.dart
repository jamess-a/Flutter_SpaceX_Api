import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/core/theme/app_color.dart';
import 'package:spacex/core/utils/dateformator.dart';
import 'package:spacex/core/utils/notifications_helper.dart';
import 'package:spacex/features/launches/domain/entities/launch.dart';
import 'package:spacex/features/launches/domain/usecases/get_launch_list_use_case.dart';
import 'package:spacex/features/launches/presentation/bloc/launch_List_bloc.dart';
import 'package:spacex/features/launches/presentation/bloc/launch_list_event.dart';
import 'package:spacex/features/launches/presentation/bloc/launch_list_state.dart';
import 'package:spacex/features/launches/presentation/pages/widgets/launch_detail_modal.dart';
import 'package:spacex/features/launches/presentation/pages/widgets/live_launch_widget.dart';
import 'package:spacex/features/launches/presentation/pages/widgets/search_launch_widget.dart';
import 'package:spacex/localization/localization_cubit.dart';
import 'package:spacex/localization/strings_en.i69n.dart';

class LaunchListScreen extends StatelessWidget {
  final GetLaunchListUseCase useCase;
  const LaunchListScreen({super.key, required this.useCase});

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

    return BlocProvider<LaunchListBloc>(
      create: (_) => LaunchListBloc(useCase)..add(FetchLaunches()),
      child: Builder(
        builder: (context) {
          void handleOpenModal(Launch launch) {
            showLaunchModalBottomSheet(context, launch);
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(strings.launches.title),
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
                    child: Text(
                      strings is Strings_en ? 'TH' : 'EN',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                SearchLaunchWidget(string: strings),
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
                                itemCount: state.launches.length.clamp(0, 10),
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
                                      trailing:
                                          launch.upcoming == true
                                              ? const Icon(
                                                Icons.schedule,
                                                color: Colors.orange,
                                              )
                                              : const Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                              ),

                                      onTap: () {
                                        handleOpenModal(launch);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Center(child: Text(strings.launches.error));
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [LiveLaunch(string: strings)],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
