import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/core/error/failures.dart';
import 'package:spacex/features/launches/domain/entities/launch_detail.dart';
import 'package:spacex/features/launches/domain/entities/rocket_detail.dart';
import 'package:spacex/features/launches/presentation/bloc/launch_detail/detail_launch_list_event.dart';
import 'package:spacex/features/launches/presentation/bloc/launch_detail/detail_launch_list_state.dart';

class DetailLaunchBloc extends Bloc<DetailLaunchEvent, DetailLaunchState> {
  final Future<Either<Failure, LaunchDetail>> Function(String) getDetailLaunch;

  DetailLaunchBloc(this.getDetailLaunch) : super(LaunchDetailInitial()) {
    on<FetchDetailLaunch>(_onFetchDetailLaunch);
  }

  Future<void> _onFetchDetailLaunch(
    FetchDetailLaunch event,
    Emitter<DetailLaunchState> emit,
  ) async {
    emit(LaunchDetailLoading());
    final id = event.id;
    final result = await getDetailLaunch(id);

    result.fold(
      (failure) => emit(LaunchDetailError(failure.message ?? 'no message')),
      (launch) => emit(LaunchDetailLoaded(launch)),
    );
  }
}

class DetailRocketBloc extends Bloc<DetailRocketLEvent , DetailRocketState>{
  final Future<Either<Failure, RocketDetail>> Function(String) getRocketDetail;

  DetailRocketBloc(this.getRocketDetail) : super(RocketDetailInitial()){
    on<FetchRocketDetail>(_onFetchRocketDetail);
  }

  Future<void> _onFetchRocketDetail(
    FetchRocketDetail event,
    Emitter<DetailRocketState> emit,
  ) async {
    emit(RocketDetailLoading());
    final id = event.id;
    final result = await getRocketDetail(id);

    result.fold(
      (failure) => emit(RocketDetailError(failure.message ?? 'no message')),
      (rocket) => emit(RocketDetailLoaded(rocket)),
    );
  }
}
