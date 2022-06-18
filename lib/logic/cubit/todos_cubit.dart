import 'dart:convert';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todo_app/data/models/sub_todo_model.dart';
import 'package:todo_app/data/models/todo_model.dart';

part 'todos_state.dart';

final TodoModel _testTodo = TodoModel(
  id: '1',
  title: 'test1',
  subTodos: [
    SubTodoModel(
      id: '11',
      title: 'test subtodo1',
      isDone: true,
    ),
    SubTodoModel(
      id: '11',
      title: 'test subtodo1',
    ),
  ],
);

class TodosCubit extends Cubit<TodosState> with HydratedMixin {
  TodosCubit() : super(TodosState(todosList: [])) {
    // hydrate();
  }

  TodosCubit.test()
      : super(
          TodosState(
            todosList: [_testTodo],
            selectedTodo: _testTodo,
          ),
        );

  void saveTodo(TodoModel newTodo) =>
      emit(state.copyWith(todosList: [...state.todosList]..add(newTodo)));

  void selectTodo(TodoModel todo) => emit(state.copyWith(selectedTodo: todo));

  void updateTodos(List<TodoModel> todosList) =>
      emit(state.copyWith(todosList: todosList));

  void deleteTodo(String id) {
    final List<TodoModel> todosList = state.todosList;
    final int index = todosList.indexWhere((element) => element.id == id);
    if (index < 0) return;

    todosList.removeAt(index);
    emit(state.copyWith(todosList: todosList));
  }

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
