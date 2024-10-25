class DetailsEvent {}

class GetDetailsEvent extends DetailsEvent {
  final int movieId;

  GetDetailsEvent({required this.movieId});
}
class GetRecommendEvent extends DetailsEvent {
  final int movieId;

  GetRecommendEvent({required this.movieId});
}
