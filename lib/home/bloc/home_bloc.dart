import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_hive_block/service/todo.dart';

import '../../service/authentification.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _auth;
  final TodoService _todo;

  HomeBloc(this._auth, this._todo) : super(HomeInitial()) {
    on<LoginEvent>((event, emit) async {
      final user =
          await _auth.authenticationUser(event.username, event.password);

      if (user != null) {
        emit(SuccessfullLogonState(user));
        emit(HomeInitial());
      }
    });

    on<RegisterAccountEvent>((event, emit) async {
      final result = await _auth.createUser(event.username, event.password);
      switch (result) {
        case UserCreationRules.success:
          emit(SuccessfullLogonState(event.username));
          break;
        case UserCreationRules.failed:
          emit(HomeInitial(error: 'There some problaem to creating account'));
          break;
        case UserCreationRules.already_exists:
          emit(HomeInitial(error: 'User already exist'));

          break;
      }
    });
    on<RegistrationServiceEvent>((event, emit) async {
      await _auth.init();
      await _todo.init();

      emit(HomeInitial());
    });

    // on<UserLoginedEvent>((event, emit) async {
    //   final login = await _auth.checkLoginUser();
    //
    //   switch (login) {
    //     case UserCreationRules.success:
    //       emit(UserLoginedState(true));
    //       break;
    //     case UserCreationRules.failed:
    //       emit(UserLoginedState(false));
    //       break;
    //     case UserCreationRules.already_exists:
    //       break;
    //   }
    // });
  }
}