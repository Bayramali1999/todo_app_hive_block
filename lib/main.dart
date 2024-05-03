import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app_hive_block/home/bloc/home_bloc.dart';
import 'package:todo_app_hive_block/service/authentification.dart';
import 'package:todo_app_hive_block/service/todo.dart';
import 'package:todo_app_hive_block/todos/todos.dart';

import 'home/home.dart';

void main() async {
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => AuthenticationService()),
          RepositoryProvider(create: (context) => TodoService()),
        ],
        child: MaterialApp(
          home: BlocProvider(
            create: (BuildContext context) => HomeBloc(
                RepositoryProvider.of<AuthenticationService>(context),
                RepositoryProvider.of<TodoService>(context))
              ..add(InitialEvent()),
            child: BlocConsumer<HomeBloc, HomeState>(
              listenWhen: (p, c) => p != c,
              listener: (context, state) {},
              builder: (context, state) {
                print('state:${state is SuccessfullLogonState}');
                return (state is SuccessfullLogonState)
                    ? TodosPage(username: state.username)
                    : HomePage();
              },
            ),
          ),
        ));
  }
}
