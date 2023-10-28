import 'package:flutter/material.dart';
import 'package:registro_pacientes/models/categoria.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.color,
    required this.categoria,
    required this.onDelete,
    required this.onUpdate,
  });

  final Color color;
  final Categoria categoria;

  //Metodos
  final void Function(Categoria) onDelete;
  final void Function(Categoria?) onUpdate;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(categoria.idCategoria),
      onDismissed: (direction) {
        onDelete(categoria);
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
                    onDelete(categoria);
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
