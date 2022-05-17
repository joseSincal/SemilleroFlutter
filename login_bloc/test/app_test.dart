import 'package:bloc_test/bloc_test.dart';
import 'package:encryptor/encryptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_bloc/Bloc/Crud_bloc/crud_bloc.dart';
import 'package:login_bloc/Bloc/Crud_bloc/crud_bloc.dart' as cr;
import 'package:login_bloc/Bloc/Crud_cliente_bloc/crud_cliente_bloc.dart';
import 'package:login_bloc/Bloc/Crud_cliente_bloc/crud_cliente_bloc.dart' as crc;
import 'package:login_bloc/Bloc/Crud_siniestro_bloc/crud_siniestro_bloc.dart';
import 'package:login_bloc/Bloc/Crud_siniestro_bloc/crud_siniestro_bloc.dart' as crs;
import 'package:login_bloc/Bloc/Login_bloc/login_bloc.dart';
import 'package:login_bloc/Models/usuario_model.dart';
import 'package:login_bloc/Providers/api_manager.dart';
import 'package:login_bloc/Providers/languaje_provider.dart';
import 'package:login_bloc/utils/app_preferences.dart';
import 'package:login_bloc/utils/app_type.dart';
import 'package:login_bloc/utils/variables.dart';

void main() {
  group('Encriptar/Desencriptar', () {
    test('Encriptar', () {
      String textEncrypt = Encryptor.encrypt(key, 'TEST');
      expect(textEncrypt, 'nh8X5vcY9wc=');
    });

    test('Desencriptar', () {
      String textDecrypt = Encryptor.decrypt(key, 'nh8X5vcY9wc=');
      expect(textDecrypt, 'TEST');
    });
  });

  /*group('API Manager', () {
    test('Buscar usuario', () async {
      var body = {"email": "test@test.com", "password": "test"};

      dynamic response = await ApiManager.shared.request(
          baseUrl: ip + ":" + port,
          pathUrl: '/usuario/buscar/email',
          type: HttpType.POST,
          bodyParams: body);

      expect(response, isNotNull);
    });

    test('Buscar cliente', () async {
      dynamic response = await ApiManager.shared.request(
          baseUrl: ip + ":" + port,
          pathUrl: '/cliente/buscar/nombre/José/and/Sincal',
          type: HttpType.GET);

      expect(response, []);
    });

    test('Calcular valor', () async {
      dynamic response = await ApiManager.shared.request(
          baseUrl: ip + ":" + port,
          pathUrl: '/procedure/calculo/10',
          type: HttpType.GET);

      expect(response, 1.2);
    });
  });*/

  group("Shared Preferences", () {
    test("Guardar y obtener preferencia", () async {
      await AppPreferences.shared.setString('test', 'TEST');
      final String? stringTest = await AppPreferences.shared.getString("test");
      expect(stringTest, 'TEST');
    });

    test("Obtener preferencia nula", () async {
      final String? value = await AppPreferences.shared.getString('testNull');
      expect(value, isNull);
    });
  });

  group('Localization', () {
    test('Obtener idioma', () async {
      LanguajeProvider langProvider = LanguajeProvider();
      langProvider.setLanguaje = await langProvider.getDefaultLanguaje();
      expect(langProvider.getLang.languageCode, 'en');
    });
  });

  group("Bloc", () {
    blocTest(
      'emits [] when nothing is added',
      build: () => LoginBloc(),
      expect: () => [],
    );

    /*blocTest(
      'emits [LoginSuccess]',
      build: () => LoginBloc(),
      act: (bloc) {
        if (bloc is LoginBloc) {
          bloc.add(LoginButtonPressed(email: 'test@test.com', password: 'test'));
        }
      },
      wait: const Duration(milliseconds: 1000),
      expect: () => [isA<LoginSuccess>()],
    );*/

    blocTest(
      'emits [Found] CrudBloc',
      build: () => CrudBloc(),
      act: (bloc) {
        if (bloc is CrudBloc) {
          bloc.add(cr.EndSearching());
        }
      },
      wait: const Duration(milliseconds: 1500),
      expect: () => [isA<cr.Found>()],
    );

    blocTest(
      'emits [Found] CrudClienteBloc',
      build: () => CrudClienteBloc(),
      act: (bloc) {
        if (bloc is CrudClienteBloc) {
          bloc.add(crc.EndSearching());
        }
      },
      wait: const Duration(milliseconds: 1500),
      expect: () => [isA<crc.Found>()],
    );

    blocTest(
      'emits [Found] CrudSiniestroBloc',
      build: () => CrudSiniestroBloc(),
      act: (bloc) {
        if (bloc is CrudSiniestroBloc) {
          bloc.add(crs.EndSearching());
        }
      },
      wait: const Duration(milliseconds: 1500),
      expect: () => [isA<crs.Found>()],
    );

    /*blocTest(
      'emits [PasswordFailure] LoginBloc',
      build: () => LoginBloc(),
      act: (bloc) {
        if (bloc is LoginBloc) {
          bloc.add(LoginButtonPressed(email: 'test@test.com', password: 'testing'));
        }
      },
      wait: const Duration(milliseconds: 1500),
      expect: () => [isA<PasswordFailure>()],
    );*/
  });

  group("Models", () {
    test("Usuario model to Json", () {
      var data = {
        "id": 5,
        "email": "testing@testing.com",
        "password": "testing",
        "username": "testing"
      };
      Usuario user = Usuario.fromService(data);
      expect(user.toJson(), data);
    });
  });
}
