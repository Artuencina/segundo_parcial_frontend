import 'package:flutter/material.dart';
import 'package:registro_pacientes/models/categoria.dart';
import 'package:registro_pacientes/widgets/category_item.dart';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({
    super.key,
    required this.color,
    required this.categorias,
  });

  final Color color;
  final List<Categoria> categorias;

  @override
  State<CategoriasScreen> createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  void _addCategoria(Categoria categoria) {
    setState(() {
      widget.categorias.add(categoria);
    });
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      showCloseIcon: true,
      content: Text('Categoria agregada'),
    ));
  }

  void _deleteCategoria(Categoria categoria) {
    //Indice para hacer undo
    final index = widget.categorias.indexOf(categoria);

    setState(() {
      widget.categorias.removeWhere(
          (element) => element.idCategoria == categoria.idCategoria);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: const Text('Categoria eliminada'),
          action: SnackBarAction(
            label: "Deshacer",
            onPressed: () {
              setState(() {
                widget.categorias.insert(index, categoria);
              });
            },
          )),
    );
  }

  void _updateCategoria(Categoria newCategoria) {
    //Actualizar estado de la pantalla
    setState(() {
      widget.categorias[widget.categorias.indexWhere(
        (element) => element.idCategoria == newCategoria.idCategoria,
      )] = newCategoria;
    });

    //Volver a la pantalla anterior
    Navigator.of(context).pop();

    //Mostrar mensaje
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      showCloseIcon: true,
      content: Text('Categoria actualizada'),
    ));
  }

  //Metodo para agregar una categoria
  void _showModalCategoria(Categoria? editCategoria) {
    //Controller para manejar el texto del input
    TextEditingController descripcionController =
        TextEditingController(text: editCategoria?.descripcion);

    //Mostrar modal para agregar categoria
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,

      //Modal
      builder: (context) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            editCategoria != null
                ? const Text('Editar categoria')
                : const Text("Agregar categoría"),
            const SizedBox(height: 20),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripcion',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  //Metodo para agregar o editar la categoria

                  onPressed: () {
                    if (editCategoria != null) {
                      editCategoria.descripcion = descripcionController.text;
                      _updateCategoria(editCategoria);
                    } else {
                      _addCategoria(
                        Categoria(
                          descripcion: descripcionController.text,
                        ),
                      );
                    }
                  },
                  child: Text(editCategoria != null ? 'Editar' : 'Agregar'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  //Cerrar modal

                  onPressed: Navigator.of(context).pop,
                  child: const Text('Cancelar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.categorias.isEmpty
          ? const Center(
              child: Text('No hay categorias'),
            )
          : ListView.builder(
              itemCount: widget.categorias.length,
              itemBuilder: (context, index) {
                return CategoryItem(
                  color: widget.color,
                  categoria: widget.categorias[index],
                  onDelete: _deleteCategoria,
                  onUpdate: _showModalCategoria,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModalCategoria(null);
        },
        backgroundColor: widget.color,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
