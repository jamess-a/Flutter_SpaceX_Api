import 'package:equatable/equatable.dart';
import 'package:spacex/features/launches/domain/entities/launch.dart';

abstract class LaunchListState extends Equatable {
  const LaunchListState();

  @override
  List<Object?> get props => [];
}

class LaunchListLoading extends LaunchListState {}

class LaunchListLoaded extends LaunchListState {
  final List<Launch> launches;

  const LaunchListLoaded(this.launches);

  @override
  List<Object?> get props => [launches];
}

class LaunchListError extends LaunchListState {
  final String message;

  const LaunchListError(this.message);

  @override
  List<Object?> get props => [message];
}
