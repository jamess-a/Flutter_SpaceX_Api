import 'package:equatable/equatable.dart';

abstract class CrewsListEvent extends Equatable {
  const CrewsListEvent();

  @override
  List<Object?> get props => [];
}

class FetchCrews extends CrewsListEvent {
  final Map<String, dynamic>? query;
  final Map<String, dynamic>? options;

  const FetchCrews({this.query, this.options});
}

class SearchCrews extends CrewsListEvent {
  final String query;
  
  const SearchCrews(this.query);

  @override
  List<Object?> get props => [];
}

enum SortCrewsCriteria { name }

class SortCrews extends CrewsListEvent {
  final SortCrewsCriteria criteria;
  final bool ascending;

  const SortCrews(this.criteria, {required this.ascending});
}
