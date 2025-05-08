import 'package:equatable/equatable.dart';
import 'package:spacex/features/launches/domain/entities/latest_launch.dart';

abstract class LatestLaunchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LatestLaunchInitial extends LatestLaunchState {}

class LatestLaunchLoading extends LatestLaunchState {}

class LatestLaunchLoaded extends LatestLaunchState {
  final LatestLaunch launch;

  LatestLaunchLoaded(this.launch);

  @override
  List<Object?> get props => [launch];
}

class LatestLaunchError extends LatestLaunchState {
  final String message;

  LatestLaunchError(this.message);

  @override
  List<Object?> get props => [message];
}
