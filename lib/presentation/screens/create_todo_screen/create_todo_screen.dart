import 'package:flutter/material.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/logic/cubit/todos_cubit.dart';
import 'package:todo_app/presentation/screens/create_todo_screen/widgets/icon_button_w.dart';
import 'package:todo_app/presentation/screens/create_todo_screen/widgets/textfield_with_buttons.dart';
import 'package:todo_app/presentation/shared/main_page_layout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final List<String> _subTodos = [];
  final Map<String, dynamic> _newTodo = {};

  void _addSubTodoController() {
    setState(() {
      _subTodos.add(_createUniqueKey());
    });
  }

  void _delete(String id) {
    setState(() {
      int index = _subTodos.indexOf(id);
      _subTodos.removeAt(index);

      final subTodosList = _newTodo['subTodos'] as List<dynamic>;

      index =
          subTodosList.indexWhere((subTodo) => (subTodo['id'] as String) == id);
      if (index < 0) return;

      subTodosList.removeAt(index);
    });
  }

  String _createUniqueKey() {
    final rng = math.Random();
    final int randomNumber = rng.nextInt(1000000);

    return '${math.pow(randomNumber, 3)}';
  }

  @override
  Widget build(BuildContext context) {
    return MainPageLayout(
      actions: [
        IconButtonW(
          icon: Icons.check,
          color: Colors.white,
          onTap: () {
            context.read<TodosCubit>().saveTodo(TodoModel.fromMap(_newTodo));
            Navigator.of(context).pop();
          },
        )
      ],
      padding: EdgeInsets.all(20.w),
      title: widget.title,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Todo',
              style: Theme.of(context).textTheme.headline5,
            ),
            TextFieldWithButtons(
              onSave: (value) {
                _newTodo['title'] = value;
                _newTodo['subTodos'] = [];

                _addSubTodoController();
              },
              allowCreateSubTodo: _subTodos.isEmpty,
            ),
            SizedBox(height: 50.h),
            Text(
              'Sub Todo\'s',
              style: Theme.of(context).textTheme.headline5,
            ),
            for (var subTodo in _subTodos.asMap().entries)
              TextFieldWithButtons(
                key: Key(subTodo.value),
                onSave: (value) {
                  (_newTodo['subTodos'] as List).add(
                      {'id': subTodo.value, 'title': value, 'isDone': false});

                  _addSubTodoController();
                },
                delete: () => _delete(subTodo.value),
                allowCreateSubTodo: subTodo.key == _subTodos.length - 1,
              ),
          ],
        ),
      ),
    );
  }
}
