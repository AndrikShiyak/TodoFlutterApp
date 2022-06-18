import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/themes/app_theme.dart';
import 'package:todo_app/logic/cubit/todos_cubit.dart';

class TestsHelper {
  TestsHelper._();

  static Widget parentWidget(Widget child) {
    return BlocProvider(
      create: (context) => TodosCubit.test(),
      child: ScreenUtilInit(
        designSize: const Size(375, 667),
        builder: (context, widget) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Builder(builder: (context) {
                return child;
              }),
            ),
          ),
        ),
      ),
    );
  }
}
