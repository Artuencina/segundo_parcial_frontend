//Provider para las fichas
// import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/ficha.dart';

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
}

//Provider para las fichas
final fichasProvider = StateNotifierProvider<FichasNotifier, List<Ficha>>(
  (ref) => FichasNotifier(),
);
