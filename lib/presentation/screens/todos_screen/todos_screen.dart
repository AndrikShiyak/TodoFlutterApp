import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/logic/cubit/todos_cubit.dart';
import 'package:todo_app/presentation/router/app_router.dart';
import 'package:todo_app/presentation/screens/create_todo_screen/create_todo_screen.dart';
import 'package:todo_app/presentation/screens/todos_screen/widgets/todo_card.dart';
import 'package:todo_app/presentation/screens/todos_screen/widgets/todos_list.dart';
import 'package:todo_app/presentation/shared/main_app_bar.dart';
import 'package:todo_app/presentation/shared/main_page_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosScreen extends StatefulWidget {
  TodosScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  List<TodoModel>? _todosList;

  @override
  Widget build(BuildContext context) {
    return MainPageLayout(
      appBar: MainAppBar(title: 'Todos'),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          if (_todosList == null) _todosList = state.todosList;

          return ReordableList(
            children: [
              for (var item in _todosList!.asMap().entries)
                TodoCard(
                  key: Key('${item.value.id}'),
                  padding: EdgeInsets.only(bottom: 10.h),
                  todo: item.value,
                  onTap: () {
                    context.read<TodosCubit>().selectTodo(item.value);
                    Navigator.of(context).pushNamed(AppRouter.todo);
                  },
                  onDismissed: () =>
                      context.read<TodosCubit>().deleteTodo(item.value.id),
                ),
            ],
            onReorder: (int oldIndex, int newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final TodoModel item = _todosList!.removeAt(oldIndex);
              _todosList!.insert(newIndex, item);

              context.read<TodosCubit>().updateTodos(_todosList!);
            },
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
