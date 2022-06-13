import 'package:todo_app/data/models/sub_todo_model.dart';
import 'package:todo_app/data/models/unique_entity.dart';

class TodoModel extends UniqueEntity {
  final String title;
  final List<SubTodoModel> subTodos;

  TodoModel({
    required String id,
    required this.title,
    this.subTodos = const [],
  }) : super(id);

  double get completePercentage {
    return this.subTodos.isNotEmpty
        ? this.subTodos.where((element) => element.isDone).length /
            this.subTodos.length
        : 0;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': super.id,
      'title': title,
      'subTodos': subTodos.map((e) => e.toMap()).toList(),
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      subTodos: (map['subTodos'] as List<dynamic>)
          .map((dynamic e) => SubTodoModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() => 'TodoModel(title: $title, subTodos: $subTodos)';

  TodoModel copyWith({
    String? title,
    List<SubTodoModel>? subTodos,
  }) {
    return TodoModel(
      id: super.id,
      title: title ?? this.title,
      subTodos: subTodos ?? this.subTodos,
    );
  }
}
