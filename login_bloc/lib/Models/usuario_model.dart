class Usuario {
  late int idUser;
  late String email;
  late String password;
  late String username;

  Usuario.fromService(Map<String, dynamic> data) {
    idUser = data['idUser'] ?? data['id'];
    email = data['email'];
    password = data['password'];
    username = data['username'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idUser,
      'email': email,
      'password': password,
      'username': username
    };
  }
}
