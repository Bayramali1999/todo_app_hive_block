import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_hive_block/service/todo.dart';
import 'package:todo_app_hive_block/todos/bloc/todo_bloc.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('todos'),
      ),
      body: BlocProvider(
        create: (BuildContext context) =>
            TodoBloc(RepositoryProvider.of<TodoService>(context))
              ..add(TodoLoadedEvent(username)),
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (BuildContext context, TodoState state) {
            if (state is TodoLoadedState) {
              return ListView(
                children: [
                  ...state.task.map(
                    (e) => ListTile(
                      title: Text(e.task),
                      trailing: Checkbox(
                        value: e.completed,
                        onChanged: (bool? value) {
                          BlocProvider.of<TodoBloc>(context)
                              .add(ToggleTodoEvent(e.task));
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('crete new tasl'),
                    trailing: Icon(Icons.edit),
                    onTap: () async {
                      final reslt = await showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: CreteTask(),
                              ));
                      if (reslt != null) {
                        BlocProvider.of<TodoBloc>(context)
                            .add(AddTodoEvent(reslt));
                      }
                    },
                  )
                ],
              );
            }
            return Container(child: Text('sdafa'));
          },
        ),
      ),
    );
  }
}

class CreteTask extends StatefulWidget {
  const CreteTask({super.key});

  @override
  State<CreteTask> createState() => _CreteTaskState();
}

class _CreteTaskState extends State<CreteTask> {
  final _cretetaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('crete new task'),
        TextFormField(
          controller: _cretetaskController,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(_cretetaskController.text);
            },
            child: Text('save'))
      ],
    );
  }
}
