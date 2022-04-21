import 'package:login_bloc/Repository/master_repository.dart';

class ClienteRepository extends MasterRepository {
  ClienteRepository._privateConstructor();
  static final MasterRepository shared =
      ClienteRepository._privateConstructor();
}
