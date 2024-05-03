import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_hive_block/home/bloc/home_bloc.dart';
import 'package:todo_app_hive_block/home/home.dart';
import 'package:todo_app_hive_block/todos/todos.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  Future<void> delay(BuildContext context, HomeState state) async {
    await Future.delayed(const Duration(milliseconds: 3000));
    if (state is SuccessfullLogonState) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TodosPage(username: state.username)));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state) {
          print('splash state ${state}');
          return Scaffold(
              body: (state is SuccessfullLogonState)
                  ? TodosPage(username: state.username)
                  : HomePage());
        },
        listener: (context, state) async {});
  }
}
