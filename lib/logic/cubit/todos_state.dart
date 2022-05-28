part of 'todos_cubit.dart';

class TodosState {
  TodosState({required this.todosList});

  final List<TodoModel> todosList;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todosList': todosList,
    };
  }

  factory TodosState.fromMap(Map<String, dynamic> map) {
    return TodosState(
      todosList: map['todosList'] as List<TodoModel>,
    );
  }
}
