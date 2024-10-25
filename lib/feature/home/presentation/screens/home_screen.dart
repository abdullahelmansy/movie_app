import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:movie_app/core/utils/text_style.dart';
import 'package:movie_app/feature/home/presentation/widgets/banner_home_widget.dart';
import 'package:movie_app/feature/home/presentation/widgets/playing_now_widget.dart';
import 'package:movie_app/feature/home/presentation/widgets/upcoming_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(30),
            const SizedBox(
              height: 400,
              width: double.infinity,
              child: BannerHomeWidget(),
            ),
            const Gap(20),
            Text(
              'Upcoming Movies',
              style: getTitleTextStyle(context, color: Colors.white),
            ),
            const Gap(10),
            const SizedBox(height: 220, child: UpcomingWidget()),
            Text(
              'Playing Now',
              style: getTitleTextStyle(context, color: Colors.white),
            ),
            const Gap(10),
            const SizedBox(
              height: 220,
              child: PlayingNowWidget(),
            ),
          ],
        ),
      ),
    ));
  }
}
