import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/details/model/details_repo.dart';
import 'package:movie_app/feature/details/model/details_response_model.dart';
import 'package:movie_app/feature/details/model/recommend_response_model.dart';
import 'package:movie_app/feature/details/presentation/bloc/details_event.dart';
import 'package:movie_app/feature/details/presentation/bloc/details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<GetDetailsEvent>(getDetails);
    on<GetRecommendEvent>(getRecommend);
  }

  DetailsResponseModel? detailsResponse;
  RecommendResponseModel? recommendResponse;

  Future<void> getDetails(GetDetailsEvent event, Emitter emit) async {
    emit(DetailsLoadingState());
    await DetailsRepo.getDetails(movieId: event.movieId).then((value) {
      if (value != null) {
        detailsResponse = value;
        if (recommendResponse != null) {
          emit(DetailsAndRecommendSuccessState(
            detailsResponseModel: detailsResponse!,
            recommendResponseModel: recommendResponse!,
          ));
        } else {
          emit(DetailsSuccessState(detailsResponseModel: value));
        }
      } else {
        emit(DetailsErrorState('Can\'t load details'));
      }
    });
  }

  Future<void> getRecommend(GetRecommendEvent event, Emitter emit) async {
    emit(RecommendLoadingState());
    await DetailsRepo.getRecommend(movieId: event.movieId).then((value) {
      if (value != null) {
        recommendResponse = value;
        if (detailsResponse != null) {
          emit(DetailsAndRecommendSuccessState(
            detailsResponseModel: detailsResponse!,
            recommendResponseModel: recommendResponse!,
          ));
        } else {
          emit(RecommendSuccessState(recommendResponseModel: value));
        }
      } else {
        emit(DetailsErrorState('Can\'t load recommendations'));
      }
    });
  }
}
