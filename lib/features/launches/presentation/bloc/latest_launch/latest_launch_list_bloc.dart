import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/core/error/failures.dart';
import 'package:spacex/features/launches/domain/entities/latest_launch.dart';
import 'package:spacex/features/launches/presentation/bloc/latest_launch/latest_launch_list_event.dart';
import 'package:spacex/features/launches/presentation/bloc/latest_launch/latest_launch_list_state.dart';

class LatestLaunchBloc extends Bloc<LatestLaunchEvent, LatestLaunchState> {
  final Future<Either<Failure,LatestLaunch>> Function() getLatestLaunch;

  LatestLaunchBloc(this.getLatestLaunch) : super(LatestLaunchInitial()) {
    on<FetchLatestLaunch>(_onFetchLatestLaunch);
  }

  Future<void> _onFetchLatestLaunch(
    FetchLatestLaunch event,
    Emitter<LatestLaunchState> emit,
  ) async {
    emit(LatestLaunchLoading());

    final result = await getLatestLaunch();

    result.fold(
      (failure) => emit(LatestLaunchError(failure.message ?? 'no message')),
      (launch) => emit(LatestLaunchLoaded(launch)),
    );
  }
}
