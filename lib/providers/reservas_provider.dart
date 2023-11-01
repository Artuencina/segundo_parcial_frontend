//Statenotifier para manejar las reservas
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/filters/reserva_filter.dart';
import 'package:registro_pacientes/models/persona.dart';
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

  List<Reserva> searchReservas(Persona? paciente, Persona? doctor,
      DateTime? fechaInicio, DateTime? fechaFinal) {
    //Filtrar por paciente, doctor y fecha
    return state.where((reserva) {
      //Si el paciente es null, no filtrar por paciente
      if (paciente != null) {
        if (reserva.persona.idPersona != paciente.idPersona) {
          return false;
        }
      }

      //Si el doctor es null, no filtrar por doctor
      if (doctor != null) {
        if (reserva.doctor.idPersona != doctor.idPersona) {
          return false;
        }
      }

      //Si la fecha de inicio es null, no filtrar por fecha
      if (fechaInicio != null && fechaFinal != null) {
        //print(reserva.fecha.isAfter(fechaInicio) ||
        //   DateUtils.isSameDay(reserva.fecha, fechaInicio));

        return (reserva.fecha.isAfter(fechaInicio) ||
                DateUtils.isSameDay(reserva.fecha, fechaInicio)) &&
            (reserva.fecha.isBefore(fechaFinal) ||
                DateUtils.isSameDay(reserva.fecha, fechaFinal));
      }

      //Si la fecha de inicio es null, no filtrar por fecha
      if (fechaInicio != null) {
        //print(reserva.fecha.isAfter(fechaInicio) ||
        //   DateUtils.isSameDay(reserva.fecha, fechaInicio));

        return reserva.fecha.isAfter(fechaInicio) ||
            DateUtils.isSameDay(reserva.fecha, fechaInicio);
      }

      //Si la fecha final es null, no filtrar por fecha
      if (fechaFinal != null) {
        print(reserva.fecha.isBefore(fechaFinal) ||
            DateUtils.isSameDay(reserva.fecha, fechaFinal));

        return reserva.fecha.isBefore(fechaFinal) ||
            DateUtils.isSameDay(reserva.fecha, fechaFinal);
      }

      return true;
    }).toList();
  }

  List<Reserva> reservasFiltradas(ReservaFilter filtro) {
    return searchReservas(
        filtro.paciente, filtro.doctor, filtro.fechaInicio, filtro.fechaFin);
  }
}

//Provider para filtro
final reservasFilterProvider =
    StateProvider<ReservaFilter>((ref) => ReservaFilter());
