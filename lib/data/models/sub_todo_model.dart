class SubTodoModel {
  final String title;
  final bool isDone;

  SubTodoModel({
    required this.title,
    this.isDone = false,
  });

  factory SubTodoModel.fromMap(Map<String, dynamic> map) {
    return SubTodoModel(
      title: map['title'] as String,
      isDone: map['isDone'] as bool,
    );
  }
}
