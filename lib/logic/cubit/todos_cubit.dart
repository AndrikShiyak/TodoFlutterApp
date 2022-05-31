import 'dart:convert';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todo_app/data/models/todo_model.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> with HydratedMixin {
  TodosCubit() : super(TodosState(todosList: [])) {
    // hydrate();
  }

  void saveTodo(TodoModel newTodo) =>
      emit(state.copyWith(todosList: [...state.todosList]..add(newTodo)));

  void selectTodo(TodoModel todo) => emit(state.copyWith(selectedTodo: todo));

  void updateTodos(List<TodoModel> todosList) =>
      emit(state.copyWith(todosList: todosList));

  @override
  TodosState? fromJson(Map<String, dynamic> json) {
    return TodosState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TodosState state) {
    // addError(Exception('Something went wrong!'), StackTrace.current);
    return state.toMap();
  }
}
