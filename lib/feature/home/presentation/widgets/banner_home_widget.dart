import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/core/functions/navigation.dart';
import 'package:movie_app/core/utils/text_style.dart';
import 'package:movie_app/feature/details/presentation/screens/details_screen.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_bloc.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_event.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_state.dart';

class BannerHomeWidget extends StatefulWidget {
  const BannerHomeWidget({
    super.key,
  });

  @override
  State<BannerHomeWidget> createState() => _BannerHomeWidgetState();
}

class _BannerHomeWidgetState extends State<BannerHomeWidget> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetTvSeriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            current is GetTvSeriesLoadingState ||
            current is GetTvSeriesSuccessState,
        builder: (context, state) {
          if (state is GetTvSeriesSuccessState) {
            var banner = context.read<HomeBloc>().tvSeriesModel.results;
            log(banner.toString()); // Check if data is being fetched
            if (banner!.isEmpty) {
              return const Center(child: Text("No TV Series Available"));
            }
            return InkWell(
              onTap: () {
                push(context,
                    DetailsScreen(movieId: banner[currentIndex].id ?? 0));
              },
              child: Column(
                children: [
                  CarouselSlider.builder(
                    itemBuilder: (context, index, realIndex) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            '${ApiConstants.baseImageUrl}${banner[index].posterPath}'),
                      );
                    },
                    itemCount: banner.length,
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      height: 300,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      // autoPlay: true,
                      // autoPlayInterval: const Duration(seconds: 3),
                      // autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      // autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    banner[currentIndex].name ?? '',
                    style: getTitleTextStyle(context, color: Colors.white),
                  )
                ],
              ),
            );
          } else if (state is GetTvSeriesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
