import 'package:equatable/equatable.dart';
import 'package:spacex/features/launches/domain/entities/launch_detail.dart';

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
