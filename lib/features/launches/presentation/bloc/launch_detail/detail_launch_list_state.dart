import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:spacex/features/launches/domain/entities/launch_detail.dart';
import 'package:spacex/features/launches/domain/entities/rocket_detail.dart';

abstract class DetailLaunchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LaunchDetailInitial extends DetailLaunchState {}

class LaunchDetailLoading extends DetailLaunchState {}

class LaunchDetailLoaded extends DetailLaunchState {
  final LaunchDetail detailLaunch;

  LaunchDetailLoaded(this.detailLaunch);

  @override
  List<Object?> get props => [detailLaunch];
}

class LaunchDetailError extends DetailLaunchState {
  final String message;

  LaunchDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

//------------------------------------------------------Rocket Detail State
abstract class DetailRocketState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RocketDetailInitial extends DetailRocketState {}

class RocketDetailLoading extends DetailRocketState {}

class RocketDetailLoaded extends DetailRocketState {
  final RocketDetail detailrocket;

  RocketDetailLoaded(this.detailrocket);

  @override
  List<Object?> get props => [detailrocket];
}

class RocketDetailError extends DetailRocketState {
  final String message;
  RocketDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
