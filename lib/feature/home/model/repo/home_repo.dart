import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movie_app/core/services/dio/dio_provider.dart';
import 'package:movie_app/feature/home/model/response/playing_now_model.dart';
import 'package:movie_app/feature/home/model/response/tv_series_model.dart';
import 'package:movie_app/feature/home/model/response/upcoming_movie_model.dart';

class HomeRepo {
  static Future<TvSeriesModel?> tvSeries() async {
    try {
      var response = await DioProvider.get(
        endpoint: 'tv/top_rated',
        queryParameters: {
          "api_key": "37d2defdc3065e2ced44982c2b126beb", // Your v3 API key
        },
      );
      if (response.statusCode == 200) {
        var model = TvSeriesModel.fromJson(response.data);
        return model;
      } else {
        log('Error: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } on DioException catch (dioError) {
      log('Dio error: ${dioError.message}');
      if (dioError.response != null) {
        log('Response data: ${dioError.response?.data}');
      }
      return null;
    } catch (e) {
      log('Unexpected error: ${e.toString()}');
      return null;
    }
  }
  static Future<MovieModel?> upcomingMovie() async {
    try {
      var response = await DioProvider.get(
        endpoint: 'movie/upcoming',
        queryParameters: {
          "api_key": "37d2defdc3065e2ced44982c2b126beb", // Your v3 API key
        },
      );
      if (response.statusCode == 200) {
        var model = MovieModel.fromJson(response.data);
        return model;
      } else {
        log('Error: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } on DioException catch (dioError) {
      log('Dio error: ${dioError.message}');
      if (dioError.response != null) {
        log('Response data: ${dioError.response?.data}');
      }
      return null;
    } catch (e) {
      log('Unexpected error: ${e.toString()}');
      return null;
    }
  }
  static Future<PlayingNowModel?> playingNow() async {
    try {
      var response = await DioProvider.get(
        endpoint: 'movie/now_playing',
        queryParameters: {
          "api_key": "37d2defdc3065e2ced44982c2b126beb", // Your v3 API key
        },
      );
      if (response.statusCode == 200) {
        var model = PlayingNowModel.fromJson(response.data);
        return model;
      } else {
        log('Error: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } on DioException catch (dioError) {
      log('Dio error: ${dioError.message}');
      if (dioError.response != null) {
        log('Response data: ${dioError.response?.data}');
      }
      return null;
    } catch (e) {
      log('Unexpected error: ${e.toString()}');
      return null;
    }
  }
  static Future<MovieModel?>getPopularMovies()async{
  try {
      var response = await DioProvider.get(
        endpoint: 'movie/popular',
        queryParameters: {
          "api_key": "37d2defdc3065e2ced44982c2b126beb", // Your v3 API key
          
        },
      );
      if (response.statusCode == 200) {
        var model = MovieModel.fromJson(response.data);
        return model;
      } else {
        log('Error: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } on DioException catch (dioError) {
      log('Dio error: ${dioError.message}');
      if (dioError.response != null) {
        log('Response data: ${dioError.response?.data}');
      }
      return null;
    } catch (e) {
      log('Unexpected error: ${e.toString()}');
      return null;
    }
 }

}
