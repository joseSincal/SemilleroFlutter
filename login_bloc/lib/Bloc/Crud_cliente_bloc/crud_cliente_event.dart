part of 'crud_cliente_bloc.dart';

abstract class CrudClienteEvent extends Equatable {}

class ButtonAdd extends CrudClienteEvent {
  final Cliente cliente;

  ButtonAdd({required this.cliente});

  @override
  List<Object?> get props => [cliente];
}

class ButtonRemove extends CrudClienteEvent {
  final String condition;
  final List<String> args;

  ButtonRemove({required this.condition, required this.args});

  @override
  List<Object?> get props => [condition, args];
}

class ButtonUpdate extends CrudClienteEvent {
  final Map<String, dynamic> cliente;
  final int id;

  ButtonUpdate({required this.cliente, required this.id});

  @override
  List<Object?> get props => [cliente];
}

class EndSearching extends CrudClienteEvent {
  @override
  List<Object?> get props => [];
}