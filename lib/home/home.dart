import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_hive_block/home/bloc/home_bloc.dart';
import 'package:todo_app_hive_block/todos/todos.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final passwordController = TextEditingController();

  final loginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is SuccessfullLogonState) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TodosPage(username: state.username)));
            }
            if (state is HomeInitial) {
              if (state.error != null) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('error'),
                          content: Text(state.error!),
                        ));
              }
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: loginController,
                    decoration: const InputDecoration(
                        hintText: 'username',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.cyan, width: 1))),
                    validator: (input) =>
                        input!.trim().isEmpty ? 'pleas enter username' : null,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: 'password',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.cyan, width: 1))),
                    validator: (input) =>
                        input!.trim().isEmpty ? 'pleas enter password' : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0))))),
                          onPressed: () => BlocProvider.of<HomeBloc>(context)
                              .add(LoginEvent(loginController.text,
                                  passwordController.text)),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 18, height: 2),
                          )),
                      ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(4.0)))),
                          ),
                          onPressed: () => BlocProvider.of<HomeBloc>(context)
                              .add(RegisterAccountEvent(loginController.text,
                                  passwordController.text)),
                          child: const Text('Register',
                              style: TextStyle(fontSize: 18, height: 2)))
                    ],
                  )
                ],
              ),
            );
            // : const Center(
            //     child: CircularProgressIndicator(),
            //   );
          },
        ),
      ),
    );
  }
}
