import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/create_todo_screen/create_todo_screen.dart';

import '../../core/constants/strings.dart';
import '../../core/exceptions/route_exception.dart';
import '../screens/home_screen/home_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String createTodo = '/create_todo';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            title: Strings.homeScreenTitle,
          ),
        );
      case createTodo:
        return MaterialPageRoute(
          builder: (_) => CreateTodoScreen(
            title: Strings.createTodoScreenTitle,
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
