import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movie_app/core/services/dio/dio_provider.dart';
import 'package:movie_app/feature/search/model/response/movie_recommend_model.dart';
import 'package:movie_app/feature/search/model/response/search_model.dart';

class SearchRepo {
 static Future<SearchModel?>search(String searchText)async{
  try {
      var response = await DioProvider.get(
        endpoint: 'search/movie',
        queryParameters: {
          "api_key": "37d2defdc3065e2ced44982c2b126beb", // Your v3 API key
          "query": searchText, // Your v3 API key
        },
      );
      if (response.statusCode == 200) {
        var model = SearchModel.fromJson(response.data);
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
 static Future<MovieRecommendationModel?>getPopularMovies()async{
  try {
      var response = await DioProvider.get(
        endpoint: 'movie/popular',
        queryParameters: {
          "api_key": "37d2defdc3065e2ced44982c2b126beb", // Your v3 API key
          
        },
      );
      if (response.statusCode == 200) {
        var model = MovieRecommendationModel.fromJson(response.data);
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