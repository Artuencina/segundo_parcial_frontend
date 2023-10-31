//Modal para buscar una categoria por nombre
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/categoria.dart';
import 'package:registro_pacientes/providers/categorias_provider.dart';

class ModalSearchCategoria extends ConsumerStatefulWidget {
  const ModalSearchCategoria({
    super.key,
  });

  @override
  ConsumerState<ModalSearchCategoria> createState() => _CategoriaSearchState();
}

class _CategoriaSearchState extends ConsumerState<ModalSearchCategoria> {
  //Variables
  TextEditingController _controller = TextEditingController();

  //Metodos
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Buscar por nombre',
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildList(List<Categoria> categorias) {
    return ListView.builder(
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        final categoria = categorias[index];
        return ListTile(
          title: Text(categoria.descripcion),
          onTap: () {
            Navigator.of(context).pop(categoria);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categorias = ref
        .watch(categoriasProvider.notifier)
        .searchCategorias(_controller.text);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar categoria"),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildList(categorias),
          ),
        ],
      ),
    );
  }
}
