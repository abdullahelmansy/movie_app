import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/presentation/screens/home_screen.dart';
import 'package:movie_app/feature/new/screens/new_screen.dart';
import 'package:movie_app/feature/search/presentation/screens/search_screen.dart';

class NavBarWidgets extends StatefulWidget {
  const NavBarWidgets({super.key});

  @override
  State<NavBarWidgets> createState() => _NavBarWidgetsState();
}

class _NavBarWidgetsState extends State<NavBarWidgets> {
  int currentInd = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const NewScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentInd],
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: const Color(0xff999999),
          selectedItemColor: Colors.white,
          currentIndex: currentInd,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          onTap: (value) {
            setState(() {
              currentInd = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_library_outlined),
              label: 'New & Hot',
            ),
          ]),
    );
  }
}
