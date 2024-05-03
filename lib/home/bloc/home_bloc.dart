import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_hive_block/bloc_status.dart';
import 'package:todo_app_hive_block/service/todo.dart';

import '../../service/authentification.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _auth;
  final TodoService _todo;

  HomeBloc(this._auth, this._todo) : super(HomeState.initial()) {
    on<LogoutEvent>((event, emit) async {
      final success = await _auth.logout(event.username);
      if (success == UserCreationRules.success) {
        emit(const HomeState(
            success: true,
            error: null,
            username: null,
            status: BlocStatus.success));
      } else {
        emit(const HomeState(
            success: false,
            error: null,
            username: null,
            status: BlocStatus.fail));
      }
    });

    on<InitialEvent>((event, emit) async {
      await _auth.init();
      await _todo.init();

      final user = await _auth.initialScreenDetector();
      if (user != null) {
        emit(HomeState(
            username: user,
            error: null,
            success: null,
            status: BlocStatus.success));
      } else {
        emit(HomeState.initial());
      }
    });

    on<LoginEvent>((event, emit) async {
      final user =
          await _auth.authenticationUser(event.username, event.password);

      if (user != null) {
        emit(HomeState(
            username: user,
            error: null,
            success: null,
            status: BlocStatus.success));
        emit(HomeState.initial());
      }
    });

    on<RegisterAccountEvent>((event, emit) async {
      final result = await _auth.createUser(event.username, event.password);
      switch (result) {
        case UserCreationRules.success:
          emit(HomeState(
              username: event.username,
              error: null,
              success: null,
              status: BlocStatus.success));
          break;
        case UserCreationRules.failed:
          emit(const HomeState(
              error: 'There some problaem to creating account',
              status: BlocStatus.fail,
              username: null,
              success: null));
          break;
        case UserCreationRules.already_exists:
          emit(const HomeState(
              error: 'User already exist',
              status: BlocStatus.fail,
              username: null,
              success: null));

          break;
      }
    });
    on<RegistrationServiceEvent>((event, emit) async {
      // emit(HomeInitial());
    });
  }
}
