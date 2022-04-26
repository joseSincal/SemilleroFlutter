import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_bloc/Models/siniestro_model.dart';
import 'package:login_bloc/Providers/siniestro_provider.dart';

part 'crud_siniestro_state.dart';
part 'crud_siniestro_event.dart';

class CrudSiniestroBloc extends Bloc<CrudSiniestroEvent, CrudSiniestroState> {
  CrudSiniestroBloc() : super(InitPage()) {
    on<ButtonAdd>((event, emit) async {
      emit(Saving());
      Siniestro siniestro = event.siniestro;
      dynamic data = await SiniestroProvider.shared.saveSiniestro(siniestro);
      await Future.delayed(const Duration(microseconds: 1000));
      data != null ? emit(Saved()) : emit(SaveError());
      await Future.delayed(const Duration(microseconds: 500));
      emit(Searching());
    });

    on<ButtonUpdate>((event, emit) async {
      emit(Updating());
      Map<String, dynamic> siniestro = event.siniestro;
      int id = event.id;
      dynamic data =
          await SiniestroProvider.shared.updateSiniestro(siniestro, id);
      await Future.delayed(const Duration(microseconds: 1000));
      data != null ? emit(Updated()) : emit(UpdateError());
      await Future.delayed(const Duration(microseconds: 500));
      emit(Searching());
    });

    on<ButtonRemove>((event, emit) async {
      emit(Updating());
      await SiniestroProvider.shared.deleteSiniestro(event.condition, event.args);
      await Future.delayed(const Duration(microseconds: 1500));
      emit(Searching());
    });

    on<EndSearching>((event, emit) async {
      await Future.delayed(const Duration(microseconds: 1500));
      emit(Found());
    });
  }
}