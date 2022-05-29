import 'package:flutter/material.dart';
import 'package:todo_app/logic/cubit/todos_cubit.dart';
import 'package:todo_app/presentation/shared/main_page_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPageLayout(
      title: context
              .select((TodosCubit cubit) => cubit.state.selectedTodo?.title) ??
          'NA',
      body: Center(child: Text('Todo Screen')),
    );
  }
}
