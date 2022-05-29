import 'package:bloc/bloc.dart';
import 'package:todo_app/data/models/todo_model.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit() : super(TodosState(todosList: []));

  void saveTodo(TodoModel newTodo) =>
      emit(state.copyWith(todosList: [...state.todosList]..add(newTodo)));

  void selectTodo(TodoModel todo) => emit(state.copyWith(selectedTodo: todo));

  void updateTodos(List<TodoModel> todosList) =>
      emit(state.copyWith(todosList: todosList));

  TodosState? fromJson(Map<String, dynamic> json) {
    return TodosState.fromMap(json);
  }

  Map<String, dynamic>? toJson(TodosState state) {
    return state.toMap();
  }
}
