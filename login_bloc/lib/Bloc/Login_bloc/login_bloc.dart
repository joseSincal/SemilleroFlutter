import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
//import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:login_bloc/Models/usuario_model.dart';
import 'package:login_bloc/Providers/api_usuario.dart';
import 'package:login_bloc/utils/app_type.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(AppStarted()) {
    on<LoginButtonPressed>((event, emit) async {
      /*
      * FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
      * await remoteConfig.fetchAndActivate();
      */
      var body = {"email": event.email, "password": event.password};

      Usuario? user = await ApiUsuario.shared.request(
          baseUrl: "192.168.1.4:9595",
          pathUrl: "/usuario/buscar/email",
          type: HttpType.POST,
          bodyParams: body);

      if (user != null) {
        if (event.password == user.password) {
          emit(LoginSuccess(username: user.username));
        } else {
          emit(PasswordFailure());
        }
      } else {
        emit(UserNotFound());
      }
    });
  }
}
