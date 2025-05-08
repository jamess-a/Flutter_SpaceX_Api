import 'package:equatable/equatable.dart';

abstract class LaunchListEvent extends Equatable {
  const LaunchListEvent();

  @override
  List<Object?> get props => [];
}

class FetchLaunches extends LaunchListEvent {
  final Map<String, dynamic>? query;
  final Map<String, dynamic>? options;

  const FetchLaunches({this.query, this.options});
}

class SearchLaunches extends LaunchListEvent {
  final String query;

  const SearchLaunches(this.query);

  @override
  List<Object?> get props => [query];
}

enum SortCriteria { name, date }

class SortLaunches extends LaunchListEvent {
  final SortCriteria criteria;
  final bool ascending;
  const SortLaunches(this.criteria, {required this.ascending});
}
