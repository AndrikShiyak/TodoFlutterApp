import 'package:flutter/material.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/logic/cubit/todos_cubit.dart';
import 'package:todo_app/presentation/router/app_router.dart';
import 'package:todo_app/presentation/screens/create_todo_screen/create_todo_screen.dart';
import 'package:todo_app/presentation/screens/todo_screen/widgets/checkbox_with_title.dart';
import 'package:todo_app/presentation/shared/appbar_progress_indicator.dart';
import 'package:todo_app/presentation/shared/main_page_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  void toggleSubTodo(
    BuildContext context, {
    required TodoModel? selectedTodo,
    required List<TodoModel> todosList,
    required int index,
  }) {
    if (selectedTodo == null) return;

    final TodoModel updatedTodo = updateTodo(index: index, todo: selectedTodo);

    final List<TodoModel> updatedTodos = updateTodosList(
      todosList: todosList,
      updatedTodo: updatedTodo,
    );

    final TodosCubit cubit = BlocProvider.of<TodosCubit>(context);

    cubit.updateTodos(updatedTodos);
    cubit.selectTodo(updatedTodo);

    if (cubit.state.selectedTodo!.subTodos
            .where((element) => element.isDone)
            .length ==
        cubit.state.selectedTodo!.subTodos.length) {
      _showDialog(context);
    }
  }

  TodoModel updateTodo({
    required TodoModel todo,
    required int index,
  }) {
    final subTodos = [...todo.subTodos];
    final subTodo = subTodos[index];
    final isDone = subTodo.isDone;
    final updatedSubTodo = subTodo.copyWith(isDone: !isDone);
    final updatedSubTodos = subTodos
      ..removeAt(index)
      ..insert(index, updatedSubTodo);
    final TodoModel updatedTodo = todo.copyWith(subTodos: updatedSubTodos);

    return updatedTodo;
  }

  List<TodoModel> updateTodosList({
    required List<TodoModel> todosList,
    required TodoModel updatedTodo,
  }) {
    final todos = [...todosList];

    final indexOfTodo =
        todos.indexWhere((element) => element.id == updatedTodo.id);

    final updatedTodos = todos
      ..removeAt(indexOfTodo)
      ..insert(indexOfTodo, updatedTodo);

    return updatedTodos;
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Todo is completed.'),
        content: Text('Do you want to archive?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No')),
          TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosCubit, TodosState>(
      builder: (context, state) {
        return MainPageLayout(
          title: state.selectedTodo?.title ?? 'NA',
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRouter.createTodo,
                    arguments: TodoScreenType.update);
              },
              icon: Icon(Icons.edit),
            )
          ],
          appBarsBottom: AppBarProgressIndicator(),
          body: ListView.builder(
            padding: EdgeInsets.all(20.w),
            itemBuilder: (context, index) => CheckboxWithTitle(
              title: state.selectedTodo?.subTodos[index].title ?? 'NA',
              value: state.selectedTodo?.subTodos[index].isDone ?? false,
              onTap: () => toggleSubTodo(
                context,
                selectedTodo: state.selectedTodo,
                todosList: state.todosList,
                index: index,
              ),
            ),
            itemCount: state.selectedTodo?.subTodos.length,
          ),
        );
      },
    );
  }
}
