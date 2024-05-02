import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_hive_block/modal/task.dart';
import 'package:todo_app_hive_block/service/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoService _todo;

  TodoBloc(this._todo) : super(TodoInitial()) {
    on<TodoLoadedEvent>((event, emit) {
      final todos = _todo.getTasks(event.username);
      emit(TodoLoadedState(todos, event.username));
    });

    on<AddTodoEvent>((event, emit) async {
      final currentState = state as TodoLoadedState;

      _todo.addTask(event.todoText, currentState.username);
      add(TodoLoadedEvent(currentState.username));
    });

    on<ToggleTodoEvent>((event, emit) async {
      final currentState = state as TodoLoadedState;
      await _todo.updateTask(event.todoText, currentState.username);
      add(TodoLoadedEvent(currentState.username));
    });
  }
}
