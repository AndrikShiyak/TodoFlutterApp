import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constants/strings.dart';
import 'package:todo_app/presentation/complete_screen/complete_screen.dart';
import 'package:todo_app/presentation/screens/home_screen/home_screen.dart';

class MainTabsScreen extends StatefulWidget {
  const MainTabsScreen({Key? key}) : super(key: key);

  @override
  State<MainTabsScreen> createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  List<Widget> _screens = [
    HomeScreen(title: Strings.homeScreenTitle),
    CompleteScreen(),
  ];

  int _screenIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
          data: const NavigationBarThemeData(
            indicatorColor: Colors.transparent,
          ),
          child: NavigationBar(
            selectedIndex: _screenIndex,
            onDestinationSelected: (index) {
              _screenIndex = index;
              setState(() {});
            },
            height: 60.h,
            backgroundColor: Theme.of(context).primaryColor,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            destinations: [
              NavigationDestination(
                icon: Icon(
                  Icons.home,
                  size: 20.h,
                ),
                selectedIcon: Icon(
                  Icons.home,
                  size: 30.h,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.done,
                  size: 20.h,
                ),
                selectedIcon: Icon(
                  Icons.done,
                  size: 30.h,
                ),
                label: 'Complete',
              ),
            ],
          )),
      body: _screens[_screenIndex],
    );
  }
}
