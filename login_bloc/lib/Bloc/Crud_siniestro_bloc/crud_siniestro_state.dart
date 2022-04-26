part of 'crud_siniestro_bloc.dart';

abstract class CrudSiniestroState {}

class InitPage extends CrudSiniestroState{}

class Searching extends CrudSiniestroState {}

class Saving extends CrudSiniestroState {}

class Removing extends CrudSiniestroState {}

class Updating extends CrudSiniestroState {}

class Found extends CrudSiniestroState {}

class Saved extends CrudSiniestroState {}

class Removed extends CrudSiniestroState {}

class Updated extends CrudSiniestroState {}

class NotFound extends CrudSiniestroState {}

class SaveError extends CrudSiniestroState {}

class RemoveError extends CrudSiniestroState {}

class UpdateError extends CrudSiniestroState {}