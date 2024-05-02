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
                      style: ListTileStyle.list,
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
                  // ListTile(
                  //   title: Text('crete new tasl'),
                  //   trailing: Icon(Icons.edit),
                  //   onTap: () async {
                  //     final reslt = await showDialog(
                  //         context: context,
                  //         builder: (context) => Dialog(
                  //               child: CreteTask(),
                  //             ));
                  //     if (reslt != null) {
                  //       BlocProvider.of<TodoBloc>(context)
                  //           .add(AddTodoEvent(reslt));
                  //     }
                  //   },
                  // )
                ],
              );
            }
            return Container(child: Text('sdafa'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final reslt = await showDialog(
              context: context,
              builder: (context) => Dialog(
                    child: CreteTask(),
                  ));
          if (reslt != null) {
            BlocProvider.of<TodoBloc>(context).add(AddTodoEvent(reslt));
          }
        },
        child: Icon(Icons.add),
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
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Crete new task\n',
            style: TextStyle(fontSize: 22),
          ),
          TextFormField(
            controller: _cretetaskController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.cyan))),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(4.0))))),
              onPressed: () {
                Navigator.of(context).pop(_cretetaskController.text);
              },
              child: Text(
                'Save todo',
                style: TextStyle(height: 3),
              ))
        ],
      ),
    );
  }
}
