//Modal para buscar una persona por su nombre y apellido, cedula o telefono
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/providers/personas_provider.dart';

class PersonaSearch extends ConsumerWidget{
  
  const PersonaSearch({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  final void Function(String) onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar persona"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          //Campo de texto para buscar una persona
          TextField(
            decoration: const InputDecoration(
              labelText: "Buscar persona",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              //Buscar personas
              ref.read(personasProvider.notifier).searchPersonas(value);
            },
          ),
          const SizedBox(height: 10),
          //Lista de personas
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                //Obtener el estado
                final state = ref.watch(personasProvider);

                //Si esta cargando, mostrar un indicador de progreso
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                //Si hay un error, mostrar un mensaje
                if (state.hasError) {
                  return const Center(
                    child: Text("Error al cargar las personas"),
                  );
                }

                //Si no hay personas, mostrar un mensaje
                if (state.personas.isEmpty) {
                  return const Center(
                    child: Text("No hay personas"),
                  );
                }

                //Mostrar la lista de personas
                return ListView.builder(
                  itemCount: state.personas.length,
                  itemBuilder: (context, index) {
                    //Obtener la persona
                    final persona = state.personas[index];

                    //Mostrar la persona
                    return ListTile(
                      title: Text("${persona.nombre} ${persona.apellido}"),
                      subtitle: Text(persona.cedula),
                      onTap: () {
                        //Seleccionar la persona
                        onSelected(persona.id);
                        //Cerrar el modal
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
    

}