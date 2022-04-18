class Usuario {
  late int idUser;
  late String email;
  late String password;
  late String username;

  Usuario.fromService(Map<String, dynamic> data) {
    this.idUser = data['idUser'];
    this.email = data['email'];
    this.password = data['password'];
    this.username = data['username'];
  }
}
