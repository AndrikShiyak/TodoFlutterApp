import 'package:flutter/material.dart';
import 'package:todo_app/logic/cubit/todos_cubit.dart';
import 'package:todo_app/presentation/router/app_router.dart';
import 'package:todo_app/presentation/screens/create_todo_screen/create_todo_screen.dart';
import 'package:todo_app/presentation/screens/home_screen/widgets/todos_list.dart';
import 'package:todo_app/presentation/shared/main_app_bar.dart';
import 'package:todo_app/presentation/shared/main_page_layout.dart';
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
      appBar: MainAppBar(title: 'Home Screen'),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          return TodosList(todosList: state.todosList);
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
