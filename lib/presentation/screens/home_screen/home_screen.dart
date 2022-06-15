import 'package:flutter/material.dart';
import 'package:todo_app/logic/cubit/todos_cubit.dart';
import 'package:todo_app/presentation/router/app_router.dart';
import 'package:todo_app/presentation/screens/create_todo_screen/create_todo_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return MainPageLayout(
      title: 'Home Screen',
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            itemBuilder: (context, index) => TodoCard(
              todo: state.todosList[index],
              onTap: () {
                context.read<TodosCubit>().selectTodo(state.todosList[index]);
                Navigator.of(context).pushNamed(AppRouter.todo);
              },
              onDismissed: () => context
                  .read<TodosCubit>()
                  .deleteTodo(state.todosList[index].id),
            ),
            separatorBuilder: (context, index) => SizedBox(height: 20.h),
            itemCount: state.todosList.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .pushNamed(AppRouter.createTodo, arguments: TodoScreenType.create),
        child: Icon(Icons.add),
      ),
    );
  }
}
