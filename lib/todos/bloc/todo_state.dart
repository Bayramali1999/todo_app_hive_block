part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final List<Task>? tasks;
  final String? username;
  final String? todoText;

  const TodoState({
    required this.status,
    required this.tasks,
    required this.username,
    required this.todoText,
  });

  final BlocStatus status;

  static TodoState initial() => const TodoState(
      tasks: [], username: null, todoText: null, status: BlocStatus.init);

  TodoState compyWith(List<Task>? tasks, String? username, String? todoText,
      BlocStatus? status) {
    return TodoState(
        status: status ?? this.status,
        tasks: tasks ?? this.tasks,
        username: username ?? this.username,
        todoText: todoText ?? this.todoText);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [tasks, username, todoText, status];
}

// class TodoInitial extends TodoState {
//   @override
//   List<Object> get props => [];
// }
//
// class TodoLoadedState extends TodoState {
//   final List<Task> task;
//   final String username;
//
//   TodoLoadedState(this.task, this.username);
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [task, username];
// }
//
// class ToggleTodoState extends TodoState {
//   final String todoTex;
//
//   ToggleTodoState(this.todoTex);
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [todoTex];
// }
