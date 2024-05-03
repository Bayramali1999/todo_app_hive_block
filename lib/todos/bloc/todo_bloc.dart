import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_hive_block/bloc_status.dart';
import 'package:todo_app_hive_block/modal/task.dart';
import 'package:todo_app_hive_block/service/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoService _todo;

  TodoBloc(this._todo) : super(TodoState.initial()) {
    on<TodoLoadedEvent>((event, emit) {
      final todos = _todo.getTasks(event.username);
      emit(TodoState(
          tasks: todos,
          username: event.username,
          status: BlocStatus.success,
          todoText: null));
    });

    on<AddTodoEvent>((event, emit) async {
      final currentState = state as TodoState;

      _todo.addTask(event.todoText, currentState.username!);
      add(TodoLoadedEvent(currentState.username!));
    });

    on<ToggleTodoEvent>((event, emit) async {
      final currentState = state as TodoState;
      await _todo.updateTask(event.todoText, currentState.username!);
      add(TodoLoadedEvent(currentState.username!));
    });
  }
}
