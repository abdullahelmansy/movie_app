import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/services/dio/dio_provider.dart';
import 'package:movie_app/core/utils/themes.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_bloc.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_event.dart';
import 'package:movie_app/feature/intro/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioProvider.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(GetTvSeriesEvent())
        ..add(GetUpcomingEvent())
        ..add(GetPlayingNowEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        themeMode: ThemeMode.light,
        theme: AppThemes.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
