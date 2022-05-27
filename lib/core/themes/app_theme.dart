import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();
  static final lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: Colors.blue,
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
