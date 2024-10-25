part of 'search_bloc.dart';

sealed class SearchEvent {}

class GetSearchEvent extends SearchEvent {
  final String name;

  GetSearchEvent({required this.name});
}

class GetPopularEvent extends SearchEvent{}