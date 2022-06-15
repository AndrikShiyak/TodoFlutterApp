part of 'todos_cubit.dart';

class TodosState {
  TodosState({
    required List<TodoModel> todosList,
    TodoModel? selectedTodo,
  })  : _todosList = todosList,
        _selectedTodo = selectedTodo;

  final List<TodoModel> _todosList;
  final TodoModel? _selectedTodo;

  List<TodoModel> get todosList {
    return [..._todosList];
  }

  TodoModel? get selectedTodo {
    return _selectedTodo?.copyWith(
      subTodos: _selectedTodo?.subTodos,
    );
  }

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
      'todosList': _todosList.map((e) => e.toMap()).toList(),
      'selectedTodo': _selectedTodo?.toMap(),
    };
  }

  factory TodosState.fromMap(Map<String, dynamic> map) {
    return TodosState(
      todosList: (map['todosList'] as List<dynamic>)
          .map((e) => TodoModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      selectedTodo:
          TodoModel.fromMap(map['selectedTodo'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() =>
      'TodosState todosList: $_todosList, selectedTodo: $_selectedTodo)';

  String toJson() => json.encode(toMap());

  factory TodosState.fromJson(String source) =>
      TodosState.fromMap(json.decode(source) as Map<String, dynamic>);
}
