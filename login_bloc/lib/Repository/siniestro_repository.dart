import 'package:login_bloc/Repository/master_repository.dart';

class SiniestroRepository extends MasterRepository {
  SiniestroRepository._privateConstructor();
  static final MasterRepository shared =
      SiniestroRepository._privateConstructor();
}
