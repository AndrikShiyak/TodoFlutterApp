part of 'todos_cubit.dart';

class TodosState {
  TodosState({
    required this.todosList,
    this.selectedTodo,
  });

  final List<TodoModel> todosList;
  final TodoModel? selectedTodo;

  TodosState copyWith({
    List<TodoModel>? todosList,
    TodoModel? selectedTodo,
  }) {
    return TodosState(
      todosList: todosList ?? this.todosList,
      selectedTodo: selectedTodo ?? this.selectedTodo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todosList': todosList,
      'selectedTodo': selectedTodo,
    };
  }

  factory TodosState.fromMap(Map<String, dynamic> map) {
    return TodosState(
      todosList: map['todosList'] as List<TodoModel>,
      selectedTodo: map['selectedTodo'] as TodoModel?,
    );
  }

  @override
  String toString() =>
      'TodosState(todosList: $todosList, selectedTodo: $selectedTodo)';
}
