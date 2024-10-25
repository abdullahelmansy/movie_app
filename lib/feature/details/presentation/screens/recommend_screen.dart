import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/feature/details/presentation/bloc/details_bloc.dart';
import 'package:movie_app/feature/details/presentation/bloc/details_state.dart';

class RecommendScreen extends StatelessWidget {
  const RecommendScreen({super.key, required this.movieId});
  final int movieId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) {
        if (state is RecommendSuccessState) {
          var movies = state.recommendResponseModel;
          return Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: movies.results?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 5,
                childAspectRatio: 1.2 / 2,
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  child: Image.network(
                      '${ApiConstants.baseImageUrl}${movies.results?[index].posterPath}'),
                );
              },
            ),
          );
        } else if (state is RecommendLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DetailsErrorState) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
          color: Colors.amberAccent,
        );
      },
    );
  }
}
