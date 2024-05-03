part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class TodoLoadedEvent extends TodoEvent {
  final String username;

  TodoLoadedEvent(this.username);

  @override
  // TODO: implement props
  List<Object?> get props => [username];
}

class AddTodoEvent extends TodoEvent {
  final String todoText;

  AddTodoEvent(this.todoText);

  @override
  // TODO: implement props
  List<Object?> get props => [todoText];
}

class ToggleTodoEvent extends TodoEvent {
  final String todoText;

  ToggleTodoEvent(this.todoText);

  @override
  // TODO: implement props
  List<Object?> get props => [todoText];
}
