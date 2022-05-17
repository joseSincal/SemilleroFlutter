import 'dart:convert';
import 'package:encryptor/encryptor.dart';
import 'package:login_bloc/Models/usuario_model.dart';
import 'package:login_bloc/utils/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider {
  UserProvider._privateConstructor();

  static final UserProvider shared = UserProvider._privateConstructor();

  Future<void> saveUserLogeadPrefs(Usuario user) async {
    final prefs = await SharedPreferences.getInstance();
    user.email = Encryptor.encrypt(key, user.email);
    user.password = Encryptor.encrypt(key, user.password);
    String userString = jsonEncode(user);
    await prefs.setString('userLogeadFlutter', userString);
    await _addToUserListPrefs(user);
  }

  Future<void> _addToUserListPrefs(Usuario user) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> nuevaLista = List<String>.empty(growable: true);
    List<String>? lista = prefs.getStringList('usersFlutter');
    if (lista == null) {
      String userString = jsonEncode(user);
      nuevaLista.add(userString);
      await prefs.setStringList('usersFlutter', nuevaLista);
      return;
    }

    bool existe = _userExist(user, lista);
    if (!existe) {
      String userString = jsonEncode(user);
      lista.add(userString);
      await prefs.remove('usersFlutter');
      await prefs.setStringList('usersFlutter', lista);
    }
  }

  bool _userExist(Usuario user, List<String> listado) {
    for (var usuario in listado) {
      var userObject = jsonDecode(usuario);
      if (userObject['email'] == user.email) {
        return true;
      }
    }
    return false;
  }

  Future<List<Usuario>> getUserEmailsPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<Usuario> usuarios = List<Usuario>.empty(growable: true);
    List<String>? lista = prefs.getStringList('usersFlutter');

    if (lista == null) {
      return usuarios;
    }

    for (var usuario in lista) {
      var userObject = jsonDecode(usuario);
      userObject['email'] = Encryptor.decrypt(key, userObject['email']);
      usuarios.add(Usuario.fromService(userObject));
    }

    return usuarios;
  }

}
