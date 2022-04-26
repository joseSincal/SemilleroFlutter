part of 'crud_bloc.dart';

abstract class CrudState {}

class InitPage extends CrudState{}

class Searching extends CrudState {}

class Saving extends CrudState {}

class Removing extends CrudState {}

class Updating extends CrudState {}

class Found extends CrudState {}

class Saved extends CrudState {}

class Removed extends CrudState {}

class Updated extends CrudState {}

class NotFound extends CrudState {}

class SaveError extends CrudState {}

class RemoveError extends CrudState {}

class UpdateError extends CrudState {}