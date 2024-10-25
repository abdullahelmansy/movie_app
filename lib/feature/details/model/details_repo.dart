import 'dart:developer';

import 'package:movie_app/core/services/dio/dio_provider.dart';
import 'package:movie_app/feature/details/model/details_response_model.dart';
import 'package:movie_app/feature/details/model/recommend_response_model.dart';

class DetailsRepo {
  static Future<DetailsResponseModel?> getDetails(
      {required int movieId}) async {
    try {
      var response = await DioProvider.get(
        endpoint: 'movie/$movieId',
        queryParameters: {
          "api_key": "37d2defdc3065e2ced44982c2b126beb", // Your v3 API key
        },
      );
      if (response.statusCode == 200) {
        var model = DetailsResponseModel.fromJson(response.data);
        return model;
      } else {
        log('Error: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  static Future<RecommendResponseModel?> getRecommend(
      {required int movieId}) async {
    try {
      var response = await DioProvider.get(
        endpoint: 'movie/$movieId/recommendations',
        queryParameters: {
          "api_key": "37d2defdc3065e2ced44982c2b126beb", // Your v3 API key
        },
      );
      if (response.statusCode == 200) {
        var model = RecommendResponseModel.fromJson(response.data);
        return model;
      } else {
        log('Error: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
