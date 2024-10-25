import 'package:movie_app/feature/home/model/repo/home_repo.dart';
import 'package:movie_app/feature/home/model/response/playing_now_model.dart';
import 'package:movie_app/feature/home/model/response/tv_series_model.dart';
import 'package:movie_app/feature/home/model/response/upcoming_movie_model.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_event.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetUpcomingEvent>(getUpcoimg);
    on<GetPlayingNowEvent>(getPlayingNow);
    on<GetTvSeriesEvent>(getTvSeries);
    add(GetUpcomingEvent());
    add(GetPlayingNowEvent());
    add(GetTvSeriesEvent());
  }
  late MovieModel upcomingMovieModel;
  late MovieModel popularMovie;
  late PlayingNowModel playingMovieModel;
  late TvSeriesModel tvSeriesModel;
  Future<void> getTvSeries(
      GetTvSeriesEvent event, Emitter<HomeState> emit) async {
    emit(GetTvSeriesLoadingState());
    await HomeRepo.tvSeries().then((value) {
      if (value != null) {
        tvSeriesModel = value;
        emit(GetTvSeriesSuccessState());
      } else {
        emit(HomeErrorState(error: 'Can\'t load'));
      }
    });
  }

  Future<void> getUpcoimg(
      GetUpcomingEvent event, Emitter<HomeState> emit) async {
    emit(GetUpcomingLoadingState());
    await HomeRepo.upcomingMovie().then((value) {
      if (value != null) {
        upcomingMovieModel = value;
        emit(GetUpcomingSuccessState());
      } else {
        emit(HomeErrorState(error: 'Can\'t load'));
      }
    });
  }

  Future<void> getPlayingNow(
      GetPlayingNowEvent event, Emitter<HomeState> emit) async {
    emit(GetPlayingNowLoadingState());
    await HomeRepo.playingNow().then((value) {
      if (value != null) {
        playingMovieModel = value;
        emit(GetPlayingNowSuccessState());
      } else {
        emit(HomeErrorState(error: 'Can\'t load'));
      }
    });
  }
  // Future<void> getPopular(GetPopularEvent event, Emitter emit) async {
  //   emit(GetPopularLoadingState());
  //   await HomeRepo.getPopularMovies().then((value) {
  //     p = value!;
  //     emit(GetSearchSuccessState());
  //   });
  // }
}
