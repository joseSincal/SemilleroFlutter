import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(AppStarted()) {
    on<LoginButtonPressed>((event, emit) {
      //log(FirebaseRemoteConfig.instance.getString('userEmail'));
      if (event.email ==
              'ottozincal@gmail.com' /*FirebaseRemoteConfig.instance.getString('userEmail')*/ &&
          event.password ==
              'heiy' /*FirebaseRemoteConfig.instance.getString('password')*/) {
        emit(LoginLoading(username: 'Jossito02'));
      } else {
        emit(LoginFailure());
      }
    });
  }
}
