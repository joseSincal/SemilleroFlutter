part of 'login_bloc.dart';

abstract class LoginState {}

class AppStarted extends LoginState {}

class LoginLoading extends LoginState {
  final String username;

  LoginLoading({required this.username});
}

class LoginFailure extends LoginState {}
