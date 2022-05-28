import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/create_todo_screen/widgets/textfield_with_buttons.dart';
import 'package:todo_app/presentation/shared/main_page_layout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

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

  void _addSubTodoController() {
    setState(() {
      _subTodos.add(_createUniqueKey());
    });
  }

  void _delete(int index) {
    setState(() {
      _subTodos.removeAt(index);
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
              save: _addSubTodoController,
              allowCreateSubTodo: _subTodos.isEmpty,
            ),
            SizedBox(height: 50.h),
            Text(
              'Sub Todo\'s',
              style: Theme.of(context).textTheme.headline5,
            ),
            for (var subTodo in _subTodos.asMap().entries)
              TextFieldWithButtons(
                save: _addSubTodoController,
                delete: () => _delete(subTodo.key),
                allowCreateSubTodo: subTodo.key == _subTodos.length - 1,
              ),
          ],
        ),
      ),
    );
  }
}
