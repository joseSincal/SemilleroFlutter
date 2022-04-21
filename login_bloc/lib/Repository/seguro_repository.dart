import 'package:login_bloc/Repository/master_repository.dart';

class SeguroRepository extends MasterRepository {
  SeguroRepository._privateConstructor();
  static final MasterRepository shared = SeguroRepository._privateConstructor();
}
