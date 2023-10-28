//Provider para las categorias
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/categoria.dart';

final categoriasProvider = ChangeNotifierProvider<CategoriasProvider>((ref) {
  return CategoriasProvider();
});

class CategoriasProvider extends ChangeNotifier {
  List<Categoria> _categorias = [];

  List<Categoria> get categorias => _categorias;

  void addCategoria(Categoria categoria) {
    _categorias.add(categoria);
    notifyListeners();
  }

  void updateCategoria(Categoria categoria) {
    final index = _categorias
        .indexWhere((element) => element.idCategoria == categoria.idCategoria);
    _categorias[index] = categoria;
    notifyListeners();
  }

  void deleteCategoria(String id) {
    _categorias.removeWhere((element) => element.idCategoria == id);
    notifyListeners();
  }
}
