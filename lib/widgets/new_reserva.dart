import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/persona.dart';
import 'package:registro_pacientes/models/reserva.dart';
import 'package:registro_pacientes/widgets/persona_search.dart';

class ModalReserva extends ConsumerStatefulWidget {
  const ModalReserva(
      {super.key,
      required this.addReserva,
      required this.validarReserva,
      required this.color});

  final void Function(Reserva) addReserva;
  final String Function(Persona?, Persona?, DateTime, String) validarReserva;
  final Color color;

  @override
  ConsumerState<ModalReserva> createState() => _ModalReservaState();
}

class _ModalReservaState extends ConsumerState<ModalReserva> {
  Persona? pacienteSeleccionado;
  Persona? doctorSeleccionado;
  DateTime fechaSeleccionada = DateTime.now();
  String horarioSeleccionado = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      alignment: Alignment.center,
      child: Column(
        children: [
          const Text(
            "Agregar Reserva",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          //Elegir persona con un textfield y un boton que
          //abre el modal de busqueda
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Paciente",
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(
                    text: pacienteSeleccionado == null
                        ? ''
                        : '${pacienteSeleccionado!.nombre} ${pacienteSeleccionado!.apellido}',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  //Mostrar el modal de busqueda
                  final persona = await showModalBottomSheet<Persona>(
                    isScrollControlled: true,
                    useSafeArea: true,
                    context: context,
                    builder: (context) {
                      return const ModalSearchPersona(
                        buscarPacientes: true,
                      );
                    },
                  );

                  if (persona != null) {
                    setState(() {
                      pacienteSeleccionado = persona;
                    });
                  }
                },
                child: const Text("Buscar"),
              ),
            ],
          ),

          const SizedBox(height: 10),
          //Elegir doctor
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Doctor",
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(
                    text: doctorSeleccionado == null
                        ? ''
                        : '${doctorSeleccionado!.nombre} ${doctorSeleccionado!.apellido}',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  //Mostrar el modal de busqueda
                  final persona = await showModalBottomSheet<Persona>(
                    isScrollControlled: true,
                    useSafeArea: true,
                    context: context,
                    builder: (context) {
                      return const ModalSearchPersona(
                        buscarPacientes: false,
                      );
                    },
                  );

                  if (persona != null) {
                    setState(() {
                      doctorSeleccionado = persona;
                    });
                  }
                },
                child: const Text("Buscar"),
              ),
            ],
          ),

          const SizedBox(height: 10),
          //Mostrar la fecha seleccionada
          Text(
            "Fecha: ${fechaSeleccionada.day}/${fechaSeleccionada.month}/${fechaSeleccionada.year}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          //Elegir fecha
          ElevatedButton(
            onPressed: () async {
              //Mostrar el datepicker
              final fecha = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
              );

              if (fecha != null) {
                setState(() {
                  fechaSeleccionada = fecha;
                });
              }

              //Actualizar la fecha
            },
            child: const Text("Elegir fecha"),
          ),
          const SizedBox(height: 10),
          //Elegir hora con un dropdown
          //y luego asignar en el horario
          //de la reserva
          DropdownButtonFormField(
            decoration: const InputDecoration(
              labelText: "Horario",
              border: OutlineInputBorder(),
            ),
            items: horarios
                .map(
                  (e) => DropdownMenuItem(value: e, child: Text(e)),
                )
                .toList(),
            onChanged: (value) {
              horarioSeleccionado = value as String;
            },
          ),

          //Botones de aceptar y cancelar
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  //Validar la reserva
                  final valido = widget.validarReserva(
                      pacienteSeleccionado,
                      doctorSeleccionado,
                      fechaSeleccionada,
                      horarioSeleccionado);

                  if (valido.isNotEmpty) {
                    //Mostrar mensaje de error en un dialog
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: Text(valido),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Aceptar"),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }

                  final reserva = Reserva(
                    persona: pacienteSeleccionado!,
                    doctor: doctorSeleccionado!,
                    fecha: fechaSeleccionada,
                    horario: horarioSeleccionado,
                  );

                  //Agregar reserva
                  widget.addReserva(reserva);
                },
                child: const Text("Aceptar"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
