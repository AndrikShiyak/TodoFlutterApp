import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/logic/cubit/todos_cubit.dart';
import 'package:todo_app/presentation/router/app_router.dart';
import 'package:todo_app/presentation/screens/todos_screen/widgets/todo_card.dart';

class TodosList extends StatelessWidget {
  const TodosList({
    Key? key,
    required this.todosList,
  }) : super(key: key);

  final List<TodoModel> todosList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // key: PageStorageKey('page'),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      itemBuilder: (context, index) => TodoCard(
        todo: todosList[index],
        onTap: () {
          context.read<TodosCubit>().selectTodo(todosList[index]);
          Navigator.of(context).pushNamed(AppRouter.todo);
        },
        onDismissed: () =>
            context.read<TodosCubit>().deleteTodo(todosList[index].id),
      ),
      separatorBuilder: (context, index) => SizedBox(height: 20.h),
      itemCount: todosList.length,
    );
  }
}
