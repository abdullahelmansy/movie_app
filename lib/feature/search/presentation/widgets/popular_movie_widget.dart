import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/core/functions/navigation.dart';
import 'package:movie_app/core/utils/text_style.dart';
import 'package:movie_app/feature/details/presentation/screens/details_screen.dart';
import 'package:movie_app/feature/search/presentation/bloc/search_bloc.dart';

class PopularMovieWidget extends StatelessWidget {
  const PopularMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchBloc()..add(GetPopularEvent()),
        child: BlocBuilder<SearchBloc, SearchState>(
          buildWhen: (previous, current) =>
              current is GetPopularLoadingState ||
              current is GetPopularSuccessState,
          builder: (context, state) {
            if (state is GetPopularSuccessState) {
              var upcoming =
                  context.read<SearchBloc>().movieRecommendationModel.results;
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: upcoming?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                        onTap: () {
                          push(context, DetailsScreen(movieId: upcoming?[index].id??0));
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  height: 150,
                                  '${ApiConstants.baseImageUrl}${upcoming?[index].posterPath}'),
                            ),
                            const Gap(10),
                            Expanded(
                              child: Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                upcoming?[index].title ?? '',
                                style: getBodyTextStyle(
                                  context,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Container(
                color: Colors.white,
              );
            }
          },
        ));
  }
}
