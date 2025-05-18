import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/core/utils/notifications_helper.dart';
import 'package:spacex/features/crews/domain/usecase/crew_usecase.dart';
import 'package:spacex/features/crews/presentation/bloc/crews/crews_list_bloc.dart';
import 'package:spacex/features/crews/presentation/bloc/crews/crews_list_event.dart';
import 'package:spacex/features/crews/presentation/bloc/crews/crews_list_state.dart';
import 'package:spacex/features/crews/presentation/pages/widgets/search_crew_widget.dart';
import 'package:spacex/localization/localization_cubit.dart';

class CrewScreen extends StatelessWidget {
  final GetCrewListUseCase getCrewListUseCase;

  const CrewScreen({super.key, required this.getCrewListUseCase});

  @override
  Widget build(BuildContext context) {
    final strings = context.watch<LanguageCubit>().state;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<CrewsListBloc>(
            create:
                (_) =>
                    CrewsListBloc(getCrewListUseCase.call)..add(FetchCrews()),
          ),
        ],
        child: Builder(
          builder:
              (context) => Column(
                children: [
                  SearchCrewWidget(string: strings),
                  Expanded(
                    child: BlocBuilder<CrewsListBloc, CrewsListState>(
                      builder: (context, state) {
                        if (state is CrewsListLoading) {
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
                        } else if (state is CrewsListloaded) {
                          if (state.crews.isEmpty) {
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
                              context.read<CrewsListBloc>().add(FetchCrews());
                            },
                            child: SizedBox(
                              height: height * 0.65,
                              child: Scrollbar(
                                thumbVisibility: true,
                                trackVisibility: true,
                                child: ListView.builder(
                                  itemCount: state.crews.length.clamp(0, 40),
                                  itemBuilder: (context, index) {
                                    final crew = state.crews[index];
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
                                          crew.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          crew.agency,
                                          style: const TextStyle(fontSize: 20),
                                        ),

                                        leading: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child:
                                              crew.imageUrl != null
                                                  ? Image.network(
                                                    crew.imageUrl,
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
                                            crew.status == true
                                                ? const Icon(
                                                  Icons.schedule,
                                                  color: Colors.orange,
                                                )
                                                : const Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                ),
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
                ],
              ),
        ),
      ),
    );
  }
}
