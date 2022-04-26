part of 'crud_siniestro_bloc.dart';

abstract class CrudSiniestroEvent extends Equatable {}

class ButtonAdd extends CrudSiniestroEvent {
  final Siniestro siniestro;

  ButtonAdd({required this.siniestro});

  @override
  List<Object?> get props => [siniestro];
}

class ButtonRemove extends CrudSiniestroEvent {
  final String condition;
  final List<String> args;

  ButtonRemove({required this.condition, required this.args});

  @override
  List<Object?> get props => [condition, args];
}

class ButtonUpdate extends CrudSiniestroEvent {
  final Map<String, dynamic> siniestro;
  final int id;

  ButtonUpdate({required this.siniestro, required this.id});

  @override
  List<Object?> get props => [siniestro];
}

class EndSearching extends CrudSiniestroEvent {
  @override
  List<Object?> get props => [];
}