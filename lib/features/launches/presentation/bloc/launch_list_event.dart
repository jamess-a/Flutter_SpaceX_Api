import 'package:equatable/equatable.dart';

abstract class LaunchListEvent extends Equatable {
  const LaunchListEvent();

  @override
  List<Object?> get props => [];
}

class FetchLaunches extends LaunchListEvent {}

class SearchLaunches extends LaunchListEvent {
  final String query;

  const SearchLaunches(this.query);

  @override
  List<Object?> get props => [query];
}

enum SortCriteria { name, date }

class SortLaunches extends LaunchListEvent {
  final SortCriteria criteria;

  const SortLaunches(this.criteria);

  @override
  List<Object?> get props => [criteria];
}
