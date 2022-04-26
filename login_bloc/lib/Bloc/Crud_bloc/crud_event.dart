part of 'crud_bloc.dart';

abstract class CrudEvent extends Equatable {}

class ButtonAdd extends CrudEvent {
  final Seguro seguro;

  ButtonAdd({required this.seguro});

  @override
  List<Object?> get props => [seguro];
}

class ButtonRemove extends CrudEvent {
  final String condition;
  final List<String> args;

  ButtonRemove({required this.condition, required this.args});

  @override
  List<Object?> get props => [condition, args];
}

class ButtonUpdate extends CrudEvent {
  final Map<String, dynamic> seguro;
  final int id;

  ButtonUpdate({required this.seguro, required this.id});

  @override
  List<Object?> get props => [seguro];
}

class EndSearching extends CrudEvent {
  @override
  List<Object?> get props => [];
}
