part of 'login_bloc.dart';

abstract class LoginState {}

class AppStarted extends LoginState {}

class LoginSuccess extends LoginState {
  final Usuario usuario;

  LoginSuccess({required this.usuario});
}

class UserNotFound extends LoginState {}

class PasswordFailure extends LoginState {}
