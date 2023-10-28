//Utilizando riverpod, podemos crear un provider para las categorias
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/categoria.dart';

final categoriasProvider =
    StateNotifierProvider<CategoriasProvider, List<Categoria>>((ref) {
  return CategoriasProvider();
});

class CategoriasProvider extends StateNotifier<List<Categoria>> {
  CategoriasProvider() : super([]);

  //Agrega una categoria a la lista
  void addCategoria(Categoria categoria) {
    state = [...state, categoria];
  }

  //Elimina una categoria de la lista
  void removeCategoria(Categoria categoria) {
    state = state
        .where((element) => element.idCategoria != categoria.idCategoria)
        .toList();
  }

  //Insertar una categoria en una posicion especifica
  void insertCategoria(int index, Categoria categoria) {
    state = [...state.sublist(0, index), categoria, ...state.sublist(index)];
  }

  //Busca una categoria por su id y la actualiza
  void updateCategoria(Categoria categoria) {
    state = [
      for (final item in state)
        if (item.idCategoria == categoria.idCategoria) categoria else item
    ];
  }
}
