//Modal para buscar personas donde se puede filtrar por nombre, cedula, telefono y si es doctor o no

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/persona.dart';
import 'package:registro_pacientes/providers/personas_provider.dart';

class ModalSearchPersona extends ConsumerStatefulWidget {
  const ModalSearchPersona({
    super.key,
    required this.buscarPacientes,
  });

  final bool buscarPacientes;

  @override
  ConsumerState<ModalSearchPersona> createState() => _ModalSearchPersonaState();
}

class _ModalSearchPersonaState extends ConsumerState<ModalSearchPersona> {
  final searchController = TextEditingController();
  bool doctores = false;
  bool pacientes = true;

  @override
  void initState() {
    super.initState();
    //Inicialmente se marca el que tenemos seleccionado
    pacientes = widget.buscarPacientes;
    doctores = !widget.buscarPacientes;
  }

  bool onlyCedula = false;

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: searchController,
        decoration: const InputDecoration(
          hintText: 'Buscar por nombre o cedula',
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildList(List<Persona> personas) {
    return ListView.builder(
      itemCount: personas.length,
      itemBuilder: (context, index) {
        final persona = personas[index];
        return ListTile(
          leading:
              Icon(persona.esDoctor ? Icons.medical_services : Icons.person),
          title: Text('${persona.nombre} ${persona.apellido}'),
          subtitle: Text(persona.cedula),
          onTap: () {
            Navigator.of(context).pop(persona);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final personas = ref
        .watch(personasProvider.notifier)
        .searchPersonas(searchController.text, doctores, pacientes, onlyCedula);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Persona'),
        actions: [
          //Abrir modal para filtrar por doctor, paciente y cedula
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, modalSetState) {
                      return AlertDialog(
                        title: const Text('Filtrar por:'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CheckboxListTile(
                              title: const Text('Doctores'),
                              value: doctores,
                              onChanged: (value) {
                                modalSetState(() {
                                  doctores = value as bool;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: const Text('Pacientes'),
                              value: pacientes,
                              onChanged: (value) {
                                modalSetState(() {
                                  pacientes = value as bool;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: const Text('Solo cedula'),
                              value: onlyCedula,
                              onChanged: (value) {
                                modalSetState(() {
                                  onlyCedula = value as bool;
                                });
                              },
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {});
                              Navigator.of(context).pop();
                            },
                            child: const Text('Aceptar'),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildSearchBar(),
          const SizedBox(height: 10),
          Expanded(
            child: _buildList(personas),
          ),
        ],
      ),
    );
  }
}
