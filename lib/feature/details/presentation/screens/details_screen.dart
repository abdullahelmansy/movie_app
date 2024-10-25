import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/core/utils/text_style.dart';
import 'package:movie_app/core/widgets/internet_excpection_widget.dart';
import 'package:movie_app/feature/details/presentation/bloc/details_bloc.dart';
import 'package:movie_app/feature/details/presentation/bloc/details_event.dart';
import 'package:movie_app/feature/details/presentation/bloc/details_state.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.movieId});
  final int movieId;
  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsBloc()
        ..add(GetDetailsEvent(movieId: movieId))
        ..add(GetRecommendEvent(movieId: movieId)),
      child: Scaffold(
        body: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            if (state is DetailsLoadingState ||
                state is RecommendLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DetailsAndRecommendSuccessState) {
              var details = state.detailsResponseModel;
              var recommendations = state.recommendResponseModel;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Movie details section
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  '${ApiConstants.baseImageUrl}${details.posterPath}'),
                            ),
                          ),
                          child: SafeArea(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            details.title ?? '',
                            style:
                                getTitleTextStyle(context, color: Colors.white),
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              Text(
                                details.releaseDate ?? '',
                                style: getBodyTextStyle(context,
                                    color: Colors.grey),
                              ),
                              const Gap(10),
                              Expanded(
                                child: Text(
                                  details.genres
                                          ?.map((genres) => genres.name)
                                          .join(',') ??
                                      '',
                                  style: getSmallTextStyle(context,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          Text(
                            details.overview ?? '',
                            textAlign: TextAlign.justify,
                            style:
                                getBodyTextStyle(context, color: Colors.grey),
                          ),
                          const Gap(10),
                          Text(
                            'More like This',
                            style:
                                getTitleTextStyle(context, color: Colors.white),
                          ),
                          const Gap(10),
                          // Recommendations section
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: recommendations.results?.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 5,
                              childAspectRatio: 1.2 / 2,
                            ),
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                child: Image.network(
                                  '${ApiConstants.baseImageUrl}${recommendations.results?[index].posterPath}',
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is DetailsErrorState) {
              return InternetExcpectionWidget(onPressed: () {
                // Handle retry logic
              });
            } else {
              return Container(); // or a placeholder widget
            }
          },
        ),
      ),
    );
  }
}
