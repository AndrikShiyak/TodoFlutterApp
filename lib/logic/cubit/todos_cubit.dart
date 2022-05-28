import 'package:bloc/bloc.dart';
import 'package:todo_app/data/models/todo_model.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit() : super(TodosState(todosList: []));

  void saveTodo(TodoModel newTodo) =>
      emit(TodosState(todosList: [...state.todosList]..add(newTodo)));

  TodosState? fromJson(Map<String, dynamic> json) {
    return TodosState.fromMap(json);
  }

  Map<String, dynamic>? toJson(TodosState state) {
    return state.toMap();
  }
}
