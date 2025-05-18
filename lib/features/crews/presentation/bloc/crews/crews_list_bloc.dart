import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/core/error/failures.dart';
import 'package:spacex/features/crews/domain/entities/crew.dart';
import 'package:spacex/features/crews/presentation/bloc/crews/crews_list_event.dart';
import 'package:spacex/features/crews/presentation/bloc/crews/crews_list_state.dart';

class CrewsListBloc extends Bloc<CrewsListEvent, CrewsListState> {
  final Future<Either<Failure, List<Crew>>> Function() getCrews;

  CrewsListBloc(this.getCrews) : super(CrewsListLoading()) {
    on<FetchCrews>(_onFetchCrews);
    on<SortCrews>(_onSortCrews);
    on<SearchCrews>(_onSearchCrews);
  }

  Future<void> _onFetchCrews(
    FetchCrews event,
    Emitter<CrewsListState> emit,
  ) async {
    emit(CrewsListLoading());
    final result = await getCrews();
    result.fold(
      (failure) => emit(CrewListError("Failed to fetch crews")),
      (crews) => emit(CrewsListloaded(crews)),
    );
  }

  void _onSearchCrews(SearchCrews event, Emitter<CrewsListState> emit) {
    final currentState = state;
    if (currentState is CrewsListloaded) {
      final query = event.query.toLowerCase();
      final filtered =
          currentState.crews
              .where((l) => l.name.toLowerCase().contains(query))
              .toList();
      emit(CrewsListloaded(filtered));
    }
  }

  void _onSortCrews(SortCrews event, Emitter<CrewsListState> emit) {
    final currentState = state;
    if (currentState is CrewsListloaded) {
      bool _isNameAsc = true;

      final sorted = [...currentState.crews];
      switch (event.criteria) {
        case SortCrewsCriteria.name:
          sorted.sort(
            (a, b) =>
                event.ascending
                    ? a.name.compareTo(b.name)
                    : b.name.compareTo(a.name),
          );
          _isNameAsc = event.ascending;
          break;
      }
      emit(CrewsListloaded(sorted));
    }
  }
}
