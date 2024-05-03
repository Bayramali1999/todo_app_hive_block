import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_hive_block/home/bloc/home_bloc.dart';
import 'package:todo_app_hive_block/home/home.dart';
import 'package:todo_app_hive_block/todos/todos.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is SuccessfullLogonState) {
            print('rout todo');
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => TodosPage(username: state.username)));
          }
          if (state is HomeInitial) {
            print('rout home');
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
          }
        },
        builder: (context, state) {
          context.read<HomeBloc>().add(InitialEvent());
          return const Center(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

//   BlocConsumer<HomeBloc, HomeState>(
//   builder: (context, state) {
//   print('splash state ${state}');
//   return Scaffold(
//   body: (state is SuccessfullLogonState)
//   ? TodosPage(username: state.username)
//       : HomePage());
//   },
//   listener: (context, state) async {});
// }
