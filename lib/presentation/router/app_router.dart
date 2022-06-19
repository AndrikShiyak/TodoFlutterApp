import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/create_todo_screen/create_todo_screen.dart';
import 'package:todo_app/presentation/screens/main_tabs_screen/main_tabs_screen.dart';
import 'package:todo_app/presentation/screens/todo_screen/todo_screen.dart';

import '../../core/constants/strings.dart';
import '../../core/exceptions/route_exception.dart';
import '../screens/home_screen/home_screen.dart';

class AppRouter {
  static const String mainTabScreen = '/';
  static const String home = '/home';
  static const String createTodo = '/create_todo';
  static const String todo = '/todo';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomeScreen(
            title: Strings.homeScreenTitle,
          ),
        );
      case createTodo:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CreateTodoScreen(
            title: Strings.createTodoScreenTitle,
            screenType: settings.arguments as TodoScreenType,
          ),
        );
      case todo:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => TodoScreen(),
        );
      case mainTabScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MainTabsScreen(),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
