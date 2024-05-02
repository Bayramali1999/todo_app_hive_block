import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_hive_block/home/bloc/home_bloc.dart';
import 'package:todo_app_hive_block/service/todo.dart';
import 'package:todo_app_hive_block/todos/todos.dart';

import '../service/authentification.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final passwordController = TextEditingController();

  final loginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('login page'),
        ),
        body: BlocProvider(
            create: (BuildContext context) => HomeBloc(
                RepositoryProvider.of<AuthenticationService>(context),
                RepositoryProvider.of<TodoService>(context))
              ..add(RegistrationServiceEvent()),
            child:
                BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
              if (state is SuccessfullLogonState) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TodosPage(username: state.username)));
              }
              if (state is HomeInitial) {
                if (state.error != null) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('error'),
                            content: Text(state.error!),
                          ));
                }
              }
            }, builder: (context, state) {
              return (state is HomeInitial)
                  ? Column(
                      children: [
                        TextFormField(
                          controller: loginController,
                          decoration: InputDecoration(hintText: 'username'),
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(hintText: 'password'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                onPressed: () =>
                                    BlocProvider.of<HomeBloc>(context).add(
                                        LoginEvent(loginController.text,
                                            passwordController.text)),
                                child: Text('Login')),
                            ElevatedButton(
                                onPressed: () =>
                                    BlocProvider.of<HomeBloc>(context).add(
                                        RegisterAccountEvent(
                                            loginController.text,
                                            passwordController.text)),
                                child: Text('register'))
                          ],
                        )
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            })));
  }
}
