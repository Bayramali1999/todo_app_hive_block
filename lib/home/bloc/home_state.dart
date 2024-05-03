part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState(
      {required this.error,
      required this.username,
      required this.success,
      required this.status});

  final String? error;
  final String? username;
  final bool? success;
  final BlocStatus status;

  static HomeState initial() => const HomeState(
      error: null, username: null, success: null, status: BlocStatus.init);

  HomeState copyWith(
      String? error, String? username, bool? success, BlocStatus? status) {
    return HomeState(
        error: error ?? this.error,
        username: username ?? this.username,
        success: success ?? this.success,
        status: status ?? this.status);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [error, username, success, status];
}
//
// class HomeInitial extends HomeState {
//   String? error;
//
//   HomeInitial({this.error});
//
//   @override
//   List<Object?> get props => [error];
// }
//
// class SuccessfullLogonState extends HomeState {
//   final String username;
//
//   SuccessfullLogonState(this.username);
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [username];
// }
//
// class RegistrationServiceState extends HomeState {
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }
//
// class UserLoginState extends HomeState {
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }
//
// class InitialState extends HomeState {
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }
//
// class LogoutState extends HomeState {
//   final bool success;
//
//   LogoutState(this.success);
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [success];
// }
