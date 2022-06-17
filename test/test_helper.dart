import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestsHelper {
  TestsHelper._();

  static Widget parentWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      builder: (context, widget) => MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: child,
          ),
        ),
      ),
    );
  }
}
