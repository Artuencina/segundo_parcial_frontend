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

  //Getters
  List<Persona> get doctores {
    return state.where((element) => element.esDoctor).toList();
  }

  List<Persona> get pacientes {
    return state.where((element) => !element.esDoctor).toList();
  }

  //Buscador con filtros
  List<Persona> searchPersonas(String? nombre_apellido, bool esDoctor,
      String? cedula, String? telefono) {
    //Si no hay ningun filtro, retornar la lista completa
    if (nombre_apellido == null &&
        cedula == null &&
        telefono == null &&
        esDoctor == false) {
      return state;
    }

    //Filtrar por nombre y apellido
    if (nombre_apellido != null) {
      return state
          .where((element) =>
              element.nombre.toLowerCase().contains(nombre_apellido) ||
              element.apellido.toLowerCase().contains(nombre_apellido))
          .toList();
    }
  }
}
