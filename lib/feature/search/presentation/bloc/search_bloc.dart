import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/search/model/repo/search_repo.dart';
import 'package:movie_app/feature/search/model/response/movie_recommend_model.dart';
import 'package:movie_app/feature/search/model/response/search_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<GetSearchEvent>(getSearch);
    on<GetPopularEvent>(getPopular);
    add(GetPopularEvent());
  }
  SearchModel? searchModel;
  late MovieRecommendationModel movieRecommendationModel;
  Future<void> getSearch(GetSearchEvent event, Emitter emit) async {
    emit(GetSearchLoadingState());
    await SearchRepo.search(event.name).then((value) {
      searchModel = value;
      emit(GetSearchSuccessState());
    });
  }

  Future<void> getPopular(GetPopularEvent event, Emitter emit) async {
    emit(GetPopularLoadingState());
    await SearchRepo.getPopularMovies().then((value) {
      movieRecommendationModel = value!;
      emit(GetPopularSuccessState());
    });
  }
}
