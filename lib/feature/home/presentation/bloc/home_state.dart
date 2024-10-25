class HomeState {}

class HomeInitial extends HomeState {}

//get tvseries
class GetTvSeriesLoadingState extends HomeState {}

class GetTvSeriesSuccessState extends HomeState {}
//get upcoming
class GetUpcomingLoadingState extends HomeState {}

class GetUpcomingSuccessState extends HomeState {}
//get plaing now
class GetPlayingNowLoadingState extends HomeState {}

class GetPlayingNowSuccessState extends HomeState {}

// final class GetPopularLoadingState extends HomeState {}

// final class GetPopularSuccessState extends HomeState {}

//error state
class HomeErrorState extends HomeState {
  final String error;

  HomeErrorState({required this.error});
}
