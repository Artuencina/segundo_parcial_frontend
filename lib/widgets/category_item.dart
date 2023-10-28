import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/categoria.dart';
import 'package:registro_pacientes/providers/categorias_provider.dart';

class CategoryItem extends ConsumerWidget {
  const CategoryItem({
    super.key,
    required this.color,
    required this.categoria,
    required this.onUpdate,
    required this.onDelete,
  });

  final Color color;
  final Categoria categoria;

  final void Function(Categoria?) onUpdate;
  final void Function(Categoria, int) onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(categoria.idCategoria),
      onDismissed: (direction) {
        onDelete(
            categoria,
            ref.read(categoriasProvider).indexWhere(
                  (element) => element.idCategoria == categoria.idCategoria,
                ));
      },
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 10),
        margin: const EdgeInsets.fromLTRB(
          0,
          5,
          10,
          5,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        color: color,
        child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.category,
                  color: Colors.white,
                ),
                const SizedBox(width: 20),
                Text(
                  categoria.descripcion,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
                //Botones para editar y eliminar
                const Spacer(),
                IconButton(
                  onPressed: () {
                    onUpdate(categoria);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    onDelete(
                        categoria,
                        ref.read(categoriasProvider).indexWhere(
                              (element) =>
                                  element.idCategoria == categoria.idCategoria,
                            ));
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
