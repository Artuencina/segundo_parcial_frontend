//Statenotifier para las personas
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/filters/persona_filter.dart';
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

  //Buscador con valores
  List<Persona> searchPersonas(
      String valueSearch, bool esDoctor, bool esPaciente, bool onlyCedula) {
    //Si no hay ningun filtro, retornar la lista completa
    if (valueSearch.isEmpty && esDoctor == false && esPaciente == false) {
      return state;
    }

    valueSearch = valueSearch.toLowerCase();
    //Filtrar por nombre, apellido o cedula pero si cedula es true
    //entonces filtrar solo por cedula
    //ademas, filtrar por si es doctor o paciente
    return state.where((element) {
      final nombre = element.nombre.toLowerCase();
      final apellido = element.apellido.toLowerCase();
      final cedula = element.cedula.toLowerCase();

      final nombreCompleto = '$nombre $apellido';

      if (onlyCedula) {
        //Buscar solamente por cedula
        return cedula.contains(valueSearch) &&
            ((esDoctor && element.esDoctor) ||
                (esPaciente && !element.esDoctor) ||
                (!esDoctor && !esPaciente));
      }
      return (nombreCompleto.contains(valueSearch) ||
              (cedula.contains(valueSearch))) &&
          ((esDoctor && element.esDoctor) ||
              (esPaciente && !element.esDoctor) ||
              (!esDoctor && !esPaciente));
    }).toList();
  }

  //Buscador con objeto filtro
  List<Persona> searchPersonasFilter(
      PersonaFilter personaFilter, bool esDoctor) {
    //Si no hay ningun filtro, retornar la lista completa
    if (personaFilter.cedula.isEmpty &&
        personaFilter.email.isEmpty &&
        personaFilter.nombreApellido.isEmpty) {
      return state.where((element) => element.esDoctor == esDoctor).toList();
    }

    //Filtrar por nombreapellido, cedula, email y si es doctor o paciente
    return state.where((element) {
      final nombre = element.nombre.toLowerCase();
      final apellido = element.apellido.toLowerCase();
      final cedula = element.cedula.toLowerCase();
      final email = element.email.toLowerCase();

      final nombreCompleto = '$nombre $apellido';

      return (nombreCompleto
                  .contains(personaFilter.nombreApellido.toLowerCase()) ||
              (cedula.contains(personaFilter.cedula.toLowerCase())) ||
              (email.contains(personaFilter.email.toLowerCase()))) &&
          (element.esDoctor == esDoctor);
    }).toList();
  }
}

//Stateprovider para los filtros de personas
final pacienteFilterProvider = StateProvider<PersonaFilter>((ref) {
  return PersonaFilter(
    nombreApellido: '',
    email: '',
    telefono: '',
    cedula: '',
    esDoctor: false,
  );
});

final doctorFilterProvider = StateProvider<PersonaFilter>((ref) {
  return PersonaFilter(
    nombreApellido: '',
    email: '',
    telefono: '',
    cedula: '',
    esDoctor: true,
  );
});
