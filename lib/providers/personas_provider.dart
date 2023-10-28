//Statenotifier para las personas
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/persona.dart';

final personasProvider =
    StateNotifierProvider<PersonasProvider, List<Persona>>((ref) {
  return PersonasProvider();
});

class PersonasProvider extends StateNotifier<List<Persona>> {
  PersonasProvider() : super([]);

  //Agrega una persona a la lista
  void addPersona(Persona persona) {
    state = [...state, persona];
  }

  //Elimina una persona de la lista
  void removePersona(Persona persona) {
    state = state.where((element) => element.cedula != persona.cedula).toList();
  }

  //Insertar una persona en una posicion especifica
  void insertPersona(int index, Persona persona) {
    //Si el index es mayor al tamaño de la lista
    //insertar al final
    if (index >= state.length) {
      state = [...state, persona];
      return;
    }

    state = [...state.sublist(0, index), persona, ...state.sublist(index)];
  }

  //Busca una persona por su id y la actualiza
  void updatePersona(Persona persona) {
    state = [
      for (final item in state)
        if (item.cedula == persona.cedula) persona else item
    ];
  }
}
