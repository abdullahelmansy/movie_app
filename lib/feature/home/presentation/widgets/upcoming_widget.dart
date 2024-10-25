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

class UpcomingWidget extends StatefulWidget {
  const UpcomingWidget({super.key});

  @override
  State<UpcomingWidget> createState() => _UpcomingWidgetState();
}

class _UpcomingWidgetState extends State<UpcomingWidget> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetUpcomingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          current is GetUpcomingLoadingState ||
          current is GetUpcomingSuccessState,
      builder: (context, state) {
        if (state is GetUpcomingSuccessState) {
          var upcoming = context.read<HomeBloc>().upcomingMovieModel.results;
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: upcoming.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {
                      push(context, DetailsScreen(movieId: upcoming[index].id));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          '${ApiConstants.baseImageUrl}${upcoming[index].posterPath}'),
                    ),
                  ),
                );
              });
        } else if (state is GetUpcomingLoadingState) {
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
