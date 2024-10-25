import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/core/functions/navigation.dart';
import 'package:movie_app/core/utils/colors.dart';
import 'package:movie_app/core/utils/text_style.dart';
import 'package:movie_app/feature/details/presentation/screens/details_screen.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_bloc.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_event.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_state.dart';

class PlayingNowWidget extends StatefulWidget {
  const PlayingNowWidget({super.key});

  @override
  State<PlayingNowWidget> createState() => _PlayingNowWidgetState();
}

class _PlayingNowWidgetState extends State<PlayingNowWidget> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetPlayingNowEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          current is GetPlayingNowLoadingState ||
          current is GetPlayingNowSuccessState,
      builder: (context, state) {
        if (state is GetPlayingNowSuccessState) {
          var palying = context.read<HomeBloc>().playingMovieModel.results;
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: palying!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    push(context,
                        DetailsScreen(movieId: palying[index].id ?? 0));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          '${ApiConstants.baseImageUrl}${palying[index].posterPath}'),
                    ),
                  ),
                );
              });
        } else if (state is GetPlayingNowLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        } else {
          return Center(
            child: Text(
              'Error',
              style: getTitleTextStyle(context, color: Colors.red),
            ),
          );
        }
      },
    );
  }
}
