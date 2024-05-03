part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  String? error;

  HomeInitial({this.error});

  @override
  List<Object?> get props => [error];
}

class SuccessfullLogonState extends HomeState {
  final String username;

  SuccessfullLogonState(this.username);

  @override
  // TODO: implement props
  List<Object?> get props => [username];
}

class RegistrationServiceState extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserLoginState extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialState extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LogoutState extends HomeState {
  final bool success;

  LogoutState(this.success);

  @override
  // TODO: implement props
  List<Object?> get props => [success];
}
