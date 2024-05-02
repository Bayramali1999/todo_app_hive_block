import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app_hive_block/home/home.dart';
import 'package:todo_app_hive_block/service/authentification.dart';
import 'package:todo_app_hive_block/service/todo.dart';

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
          title: 'Flutter Demo',
          home: HomePage()
          ,
        ));
  }
}
