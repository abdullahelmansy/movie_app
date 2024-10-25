import 'package:flutter/material.dart';
import 'package:movie_app/core/functions/navigation.dart';
import 'package:movie_app/core/widgets/nav_bar_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      pushReplacement(context, const NavBarWidgets());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo1.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
