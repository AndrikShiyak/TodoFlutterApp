import 'package:todo_app/data/models/sub_todo_model.dart';

class TodoModel {
  final String title;
  final List<SubTodoModel> subTodos;

  TodoModel({
    required this.title,
    this.subTodos = const [],
  });
}
