part of 'crud_cliente_bloc.dart';

abstract class CrudClienteState {}

class InitPage extends CrudClienteState{}

class Searching extends CrudClienteState {}

class Saving extends CrudClienteState {}

class Removing extends CrudClienteState {}

class Updating extends CrudClienteState {}

class Found extends CrudClienteState {}

class Saved extends CrudClienteState {}

class Removed extends CrudClienteState {}

class Updated extends CrudClienteState {}

class NotFound extends CrudClienteState {}

class SaveError extends CrudClienteState {}

class RemoveError extends CrudClienteState {}

class UpdateError extends CrudClienteState {}