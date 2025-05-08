import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/core/error/failures.dart';
import 'package:spacex/features/launches/domain/entities/launch.dart';
import 'launch_list_event.dart';
import 'launch_list_state.dart';

class LaunchListBloc extends Bloc<LaunchListEvent, LaunchListState> {
  final Future<Either<Failure, List<Launch>>> Function() getLaunches;

  LaunchListBloc(this.getLaunches) : super(LaunchListLoading()) {
    on<FetchLaunches>(_onFetchLaunches);
    on<SearchLaunches>(_onSearchLaunches);
    on<SortLaunches>(_onSortLaunches);
  }

  Future<void> _onFetchLaunches(
    FetchLaunches event,
    Emitter<LaunchListState> emit,
  ) async {
    emit(LaunchListLoading());
    final result = await getLaunches();
    result.fold(
      (failure) => emit(LaunchListError("Failed to fetch launches")),
      (launches) => emit(LaunchListLoaded(launches)),
    );
  }

  void _onSearchLaunches(SearchLaunches event, Emitter<LaunchListState> emit) {
    final currentState = state;
    if (currentState is LaunchListLoaded) {
      final query = event.query.toLowerCase();
      final filtered =
          currentState.launches
              .where((l) => l.name.toLowerCase().contains(query))
              .toList();
      emit(LaunchListLoaded(filtered));
    }
  }

  void _onSortLaunches(SortLaunches event, Emitter<LaunchListState> emit) {
    final currentState = state;
    if (currentState is LaunchListLoaded) {
      bool _isNameAsc = true;
      bool _isDateAsc = true;
      final sorted = [...currentState.launches];
      switch (event.criteria) {
        case SortCriteria.name:
          sorted.sort(
            (a, b) =>
                event.ascending
                    ? a.name.compareTo(b.name)
                    : b.name.compareTo(a.name),
          );
          _isNameAsc = event.ascending;
          break;

        case SortCriteria.date:
          sorted.sort(
            (a, b) =>
                event.ascending
                    ? a.dateUtc.compareTo(b.dateUtc)
                    : b.dateUtc.compareTo(a.dateUtc),
          );
          _isDateAsc = event.ascending;
          break;
      }
      emit(LaunchListLoaded(sorted));
    }
  }
}
