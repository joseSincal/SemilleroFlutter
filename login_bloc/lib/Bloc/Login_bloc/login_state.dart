part of 'login_bloc.dart';

abstract class LoginState {}

class AppStarted extends LoginState {}

class LoginSuccess extends LoginState {
  final String username;

  LoginSuccess({required this.username});
}

class UserNotFound extends LoginState {}

class PasswordFailure extends LoginState {}
