import 'package:flutter/material.dart';
import 'package:todo_app/logic/cubit/todos_cubit.dart';
import 'package:todo_app/presentation/router/app_router.dart';
import 'package:todo_app/presentation/screens/home_screen/widgets/todo_card.dart';
import 'package:todo_app/presentation/shared/main_page_layout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<String> titlesList;

  @override
  void initState() {
    titlesList = List.generate(7, (index) => 'Card ${index + 1}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todosList =
        context.select((TodosCubit cubit) => cubit.state.todosList);

    return MainPageLayout(
      title: 'Home Screen',
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemBuilder: (context, index) =>
            TodoCard(title: todosList[index].title),
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        itemCount: todosList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(AppRouter.createTodo),
        child: Icon(Icons.add),
      ),
    );
  }
}
