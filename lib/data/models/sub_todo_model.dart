import 'package:todo_app/data/models/unique_entity.dart';

class SubTodoModel extends UniqueEntity {
  final String title;
  final bool isDone;

  SubTodoModel({
    required String id,
    required this.title,
    this.isDone = false,
  }) : super(id);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': super.id,
      'title': title,
      'isDone': isDone,
    };
  }

  factory SubTodoModel.fromMap(Map<String, dynamic> map) {
    return SubTodoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  SubTodoModel copyWith({
    String? title,
    bool? isDone,
  }) {
    return SubTodoModel(
      id: super.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  String toString() => 'SubTodoModel(title: $title, isDone: $isDone)';
}
