import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_bloc/Models/seguro_model.dart';
import 'package:login_bloc/Providers/seguro_provider.dart';

part 'crud_state.dart';
part 'crud_event.dart';

class CrudBloc extends Bloc<CrudEvent, CrudState> {
  CrudBloc() : super(InitPage()) {
    on<ButtonAdd>((event, emit) async {
      emit(Saving());
      Seguro seguro = event.seguro;
      dynamic data = await SeguroProvider.shared.saveSeguro(seguro);
      await Future.delayed(const Duration(microseconds: 1000));
      data != null ? emit(Saved()) : emit(SaveError());
      await Future.delayed(const Duration(microseconds: 500));
      emit(Searching());
    });

    on<ButtonUpdate>((event, emit) async {
      emit(Updating());
      Map<String, dynamic> seguro = event.seguro;
      int id = event.id;
      dynamic data =
          await SeguroProvider.shared.updateSeguro(seguro, id);
      await Future.delayed(const Duration(microseconds: 1000));
      data != null ? emit(Updated()) : emit(UpdateError());
      await Future.delayed(const Duration(microseconds: 500));
      emit(Searching());
    });

    on<ButtonRemove>((event, emit) async {
      emit(Updating());
      await SeguroProvider.shared.deleteSeguro(event.condition, event.args);
      await Future.delayed(const Duration(microseconds: 1500));
      emit(Searching());
    });

    on<EndSearching>((event, emit) async {
      await Future.delayed(const Duration(microseconds: 1500));
      emit(Found());
    });
  }
}
