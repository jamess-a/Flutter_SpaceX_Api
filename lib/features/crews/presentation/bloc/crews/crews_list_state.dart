import 'package:equatable/equatable.dart';
import 'package:spacex/features/crews/domain/entities/crew.dart';

abstract class CrewsListState extends Equatable {
  const CrewsListState();

  @override
  List<Object?> get props => [];
}

class CrewsListLoading extends CrewsListState {}

class CrewsListloaded extends CrewsListState {
  final List<Crew> crews;

  const CrewsListloaded(this.crews);

  @override
  List<Object> get props => [crews];
}

class CrewListError extends CrewsListState {
  final String message;

  const CrewListError(this.message);

  @override
  List<Object?> get props => [message];
}
