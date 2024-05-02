part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoadedState extends TodoState {
  final List<Task> task;
  final String username;

  TodoLoadedState(this.task, this.username);

  @override
  // TODO: implement props
  List<Object?> get props => [task, username];
}

class ToggleTodoState extends TodoState {
  final String todoTex;

  ToggleTodoState(this.todoTex);

  @override
  // TODO: implement props
  List<Object?> get props => [todoTex];
}
