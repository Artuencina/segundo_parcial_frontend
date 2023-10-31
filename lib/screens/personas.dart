import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/persona.dart';
import 'package:registro_pacientes/providers/personas_provider.dart';
import 'package:registro_pacientes/widgets/persona_item.dart';

class PersonasScreen extends ConsumerStatefulWidget {
  const PersonasScreen({
    super.key,
    required this.mainColor,
    required this.esDoctor,
  });

  final Color mainColor;
  final bool esDoctor;

  @override
  ConsumerState<PersonasScreen> createState() => _PersonasScreenState();
}

class _PersonasScreenState extends ConsumerState<PersonasScreen> {
  void _addPaciente(Persona persona) {
    //Agregar persona al estado
    ref.read(personasProvider.notifier).addPersona(persona);

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        content: Text('${widget.esDoctor ? 'Doctor' : 'Paciente'} agregado'),
      ),
    );
  }

  void _updatePaciente(Persona newPersona) {
    ref.read(personasProvider.notifier).updatePersona(newPersona);
  }

  void _deletePaciente(Persona persona) {
    final index = ref.read(personasProvider).indexOf(persona);

    //Eliminar persona
    ref.read(personasProvider.notifier).removePersona(persona);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.esDoctor ? 'Doctor' : 'Paciente'} eliminado'),
        action: SnackBarAction(
          label: "Deshacer",
          onPressed: () {
            ref.read(personasProvider.notifier).insertPersona(index, persona);
          },
        ),
      ),
    );
  }

  bool validarEmail(String email) {
    final RegExp regex = RegExp(
      r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return regex.hasMatch(email);
  }

  void _showModalPersona(Persona? editPersona) {
    TextEditingController nombreController = TextEditingController(
      text: editPersona != null ? editPersona.nombre : "",
    );
    TextEditingController apellidoController = TextEditingController(
      text: editPersona != null ? editPersona.apellido : "",
    );
    TextEditingController telefonoController = TextEditingController(
      text: editPersona != null ? editPersona.telefono : "",
    );
    TextEditingController emailController = TextEditingController(
      text: editPersona != null ? editPersona.email : "",
    );
    TextEditingController cedulaController = TextEditingController(
      text: editPersona != null ? editPersona.cedula : "",
    );

    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,

      //Modal
      builder: (context) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(editPersona != null
                ? "Editar ${widget.esDoctor ? 'Doctor' : 'Paciente'}"
                : "Agregar ${widget.esDoctor ? 'Doctor' : 'Paciente'}"),
            const SizedBox(height: 20),
            TextField(
              controller: nombreController,
              //Aca se ponen todas las cuestiones de estilo
              //del input
              decoration: const InputDecoration(
                labelText: "Nombre",
                icon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: apellidoController,
              decoration: const InputDecoration(
                labelText: "Apellido",
                icon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: telefonoController,
              decoration: const InputDecoration(
                labelText: "Telefono",
                icon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              controller: cedulaController,
              decoration: const InputDecoration(
                labelText: "Cedula",
                icon: Icon(Icons.credit_card),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                icon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  //Metodo para agregar o editar la categoria

                  onPressed: () {
                    if (editPersona != null) {
                      editPersona.nombre = nombreController.text;
                      editPersona.apellido = apellidoController.text;
                      editPersona.telefono = telefonoController.text;
                      editPersona.email = emailController.text;
                      editPersona.cedula = cedulaController.text;
                      _updatePaciente(editPersona);
                    } else {
                      _addPaciente(
                        Persona(
                          nombre: nombreController.text,
                          apellido: apellidoController.text,
                          telefono: telefonoController.text,
                          email: emailController.text,
                          cedula: cedulaController.text,
                          esDoctor: widget.esDoctor,
                        ),
                      );
                    }
                  },
                  child: Text(editPersona != null ? 'Editar' : 'Agregar'),
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
    final personas = ref
        .watch(personasProvider)
        .where((element) => element.esDoctor == widget.esDoctor)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de pacientes"),
        backgroundColor: widget.mainColor,
        foregroundColor: Colors.white,
        actions: [
          //Boton de filtro
          IconButton(
            onPressed: () {
              //Abrir cuadro de dialogo para filtrar con un inputtext
              //y tres checkbox para doctor, paciente y cedula
            },
            icon: const Icon(Icons.filter_alt),
          ),
        ],
      ),
      body: personas.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                      widget.esDoctor
                          ? Icons.medical_services_outlined
                          : Icons.person_outline,
                      size: 100,
                      color: widget.mainColor),
                  const SizedBox(height: 10),
                  Text("No hay ${widget.esDoctor ? 'doctores' : 'pacientes'}"),
                ],
              ),
            )
          : ListView.builder(
              itemCount: personas.length,
              itemBuilder: (context, index) {
                return PersonaItem(
                  icon: widget.esDoctor ? Icons.medical_services : Icons.person,
                  color: widget.mainColor,
                  persona: personas[index],
                  deletePersona: _deletePaciente,
                  updatePersona: _showModalPersona,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModalPersona(null);
        },
        backgroundColor: widget.mainColor,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
