//Provider para las fichas
// import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/ficha.dart';
import 'package:registro_pacientes/models/filters/ficha_filter.dart';

class FichasNotifier extends StateNotifier<List<Ficha>> {
  FichasNotifier() : super([]);

  //Metodo para agregar una ficha
  void addFicha(Ficha ficha) {
    state = [...state, ficha];
  }

  //Metodo para eliminar una ficha
  void deleteFicha(Ficha ficha) {
    state = state.where((element) => element.idFicha != ficha.idFicha).toList();
  }

  //Metodo para editar una ficha
  void editFicha(Ficha ficha) {
    state = state.map((element) {
      if (element.idFicha == ficha.idFicha) {
        return ficha;
      } else {
        return element;
      }
    }).toList();
  }

  //Metodo para filtrar las fichas
  List<Ficha> filterFichas(FichaFilter filter) {
    return state
        .where((element) =>
            (filter.pacientes.isEmpty ||
                filter.pacientes.contains(element.paciente)) &&
            (filter.doctores.isEmpty ||
                filter.doctores.contains(element.doctor)) &&
            (filter.categorias.isEmpty ||
                filter.categorias.contains(element.categoria)) &&
            (filter.fechaInicio == null ||
                element.fecha.isAfter(filter.fechaInicio!)) &&
            (filter.fechaFin == null ||
                element.fecha.isBefore(filter.fechaFin!)))
        .toList();
  }
}

//Provider para las fichas
final fichasProvider = StateNotifierProvider<FichasNotifier, List<Ficha>>(
  (ref) => FichasNotifier(),
);

//Provider para filtrar las fichas
final fichasFilterProvider = StateProvider<FichaFilter>((ref) {
  return FichaFilter();
});
