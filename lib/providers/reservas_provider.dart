//Statenotifier para manejar las reservas
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/reserva.dart';

final reservasProvider = StateNotifierProvider<ReservasProvider, List<Reserva>>(
    (ref) => ReservasProvider());

class ReservasProvider extends StateNotifier<List<Reserva>> {
  ReservasProvider() : super([]);

  //Metodos
  void addReserva(Reserva reserva) {
    state = [...state, reserva];
  }

  void removeReserva(Reserva reserva) {
    state = state
        .where((element) => element.idReserva != reserva.idReserva)
        .toList();
  }

  void insertReserva(int index, Reserva reserva) {
    //Si el index es mayor al tamaño de la lista, insertar al final
    if (index > state.length) {
      state = [...state, reserva];
    }
    state = [...state.sublist(0, index), reserva, ...state.sublist(index)];
  }
}
