import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
//import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:login_bloc/Models/usuario_model.dart';
import 'package:login_bloc/Providers/api_manager.dart';
import 'package:login_bloc/Providers/user_provider.dart';
import 'package:login_bloc/utils/app_type.dart';
import 'package:login_bloc/utils/variables.dart';

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

      dynamic bodyRequest = await ApiManager.shared.request(
          baseUrl: ip + ":" + port,
          pathUrl: "/usuario/buscar/email",
          type: HttpType.POST,
          bodyParams: body);

      if (bodyRequest != null) {
        Usuario user = Usuario.fromService(bodyRequest);
        if (event.password == user.password) {
          await UserProvider.shared.saveUserLogeadPrefs(user);
          emit(LoginSuccess(usuario: user));
        } else {
          emit(PasswordFailure());
        }
      } else {
        emit(UserNotFound());
      }
    });
  }



  
}
