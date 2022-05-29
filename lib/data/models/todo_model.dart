import 'package:todo_app/data/models/sub_todo_model.dart';

class TodoModel {
  final String title;
  final List<SubTodoModel> subTodos;

  TodoModel({
    required this.title,
    this.subTodos = const [],
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      title: map['title'] as String,
      subTodos: (map['subTodos'] as List<dynamic>)
          .map((dynamic e) => SubTodoModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() => 'TodoModel(title: $title, subTodos: $subTodos)';
}
