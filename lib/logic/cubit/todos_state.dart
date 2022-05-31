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
      'todosList': todosList.map((e) => e.toMap()).toList(),
      'selectedTodo': selectedTodo?.toMap(),
    };
  }

  factory TodosState.fromMap(Map<String, dynamic> map) {
    return TodosState(
      todosList: (map['todosList'] as List<dynamic>)
          .map((e) => TodoModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      selectedTodo: map['selectedTodo'],
    );
  }

  @override
  String toString() =>
      'TodosState(todosList: $todosList, selectedTodo: $selectedTodo)';

  String toJson() => json.encode(toMap());

  factory TodosState.fromJson(String source) =>
      TodosState.fromMap(json.decode(source) as Map<String, dynamic>);
}
