import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_bloc/Models/cliente_model.dart';
import 'package:login_bloc/Providers/cliente_provider.dart';

part 'crud_cliente_event.dart';
part 'crud_cliente_state.dart';

class CrudClienteBloc extends Bloc<CrudClienteEvent, CrudClienteState> {
  CrudClienteBloc() : super(InitPage()) {
    on<ButtonAdd>((event, emit) async {
      emit(Saving());
      Cliente cliente = event.cliente;
      dynamic data = await ClienteProvider.shared.saveCliente(cliente);
      await Future.delayed(const Duration(microseconds: 1000));
      data != null ? emit(Saved()) : emit(SaveError());
      await Future.delayed(const Duration(microseconds: 500));
      emit(Searching());
    });

    on<ButtonUpdate>((event, emit) async {
      emit(Updating());
      Map<String, dynamic> cliente = event.cliente;
      int id = event.id;
      dynamic data =
          await ClienteProvider.shared.updateCliente(cliente, id);
      await Future.delayed(const Duration(microseconds: 1000));
      data != null ? emit(Updated()) : emit(UpdateError());
      await Future.delayed(const Duration(microseconds: 500));
      emit(Searching());
    });

    on<ButtonRemove>((event, emit) async {
      emit(Updating());
      await ClienteProvider.shared.deleteCliente(event.condition, event.args);
      await Future.delayed(const Duration(microseconds: 1500));
      emit(Searching());
    });

    on<EndSearching>((event, emit) async {
      await Future.delayed(const Duration(microseconds: 1500));
      emit(Found());
    });
  }
}