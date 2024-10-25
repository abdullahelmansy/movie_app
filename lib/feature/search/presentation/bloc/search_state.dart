part of 'search_bloc.dart';

sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class GetSearchLoadingState extends SearchState {}

final class GetSearchSuccessState extends SearchState {}

final class GetPopularLoadingState extends SearchState {}

final class GetPopularSuccessState extends SearchState {}
