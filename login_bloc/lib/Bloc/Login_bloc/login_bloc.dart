import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(AppStarted()) {
    on<LoginButtonPressed>((event, emit) {
      if (event.email == 'ottozincal@gmail.com' && event.password == 'heiy') {
        emit(LoginLoading(username: 'Jossito02'));
      } else {
        emit(LoginFailure());
      }
    });
  }
}
