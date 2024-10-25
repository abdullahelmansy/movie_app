import 'package:movie_app/feature/details/model/details_response_model.dart';
import 'package:movie_app/feature/details/model/recommend_response_model.dart';

class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoadingState extends DetailsState {}

class DetailsSuccessState extends DetailsState {
  final DetailsResponseModel detailsResponseModel;

  DetailsSuccessState({required this.detailsResponseModel});
}
class RecommendLoadingState extends DetailsState {}

class RecommendSuccessState extends DetailsState {
  final RecommendResponseModel recommendResponseModel;

  RecommendSuccessState({required this.recommendResponseModel});

}
class DetailsAndRecommendSuccessState extends DetailsState {
  final DetailsResponseModel detailsResponseModel;
  final RecommendResponseModel recommendResponseModel;

  DetailsAndRecommendSuccessState({
    required this.detailsResponseModel,
    required this.recommendResponseModel,
  });
}


class DetailsErrorState extends DetailsState {
  final String error;

  DetailsErrorState(this.error);
}
