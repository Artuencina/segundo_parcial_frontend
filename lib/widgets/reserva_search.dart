//Modal de busqueda de reservas que permite buscar por
//Paciente, doctor, fecha de inicio y fecha fin

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/persona.dart';
import 'package:registro_pacientes/models/reserva.dart';
import 'package:registro_pacientes/providers/reservas_provider.dart';
import 'package:registro_pacientes/widgets/persona_search.dart';

class ModalSearchReserva extends ConsumerStatefulWidget {
  const ModalSearchReserva({
    super.key,
  });

  @override
  ConsumerState<ModalSearchReserva> createState() => _ModalSearchReservaState();
}

class _ModalSearchReservaState extends ConsumerState<ModalSearchReserva> {
  //Datos de filtros
  DateTime? fechaInicio;
  DateTime? fechaFinal;
  Persona? paciente;
  Persona? doctor;

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      //Como buscador se tienen dos selectores de fecha y un buscador de personas
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white70,
                      elevation: 0.5,
                    ),
                    onPressed: () async {
                      //Mostrar el selector de fecha de inicio
                      final fecha = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      //Si la fecha es null, no se selecciono una fecha
                      if (fecha != null) {
                        setState(() {
                          fechaInicio = fecha;
                        });
                      }
                    },
                    //En el botón vamos a poner un icono de calendario
                    //el texto de la fecha y un iconbutton para borrar la fecha
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.purple,
                        ),
                        const Spacer(),
                        Text(
                          fechaInicio == null
                              ? "Fecha inicio"
                              : '${fechaInicio!.day}/${fechaInicio!.month}/${fechaInicio!.year}',
                          style: const TextStyle(color: Colors.black),
                        ),
                        const Spacer(),
                        if (fechaInicio != null)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                fechaInicio = null;
                              });
                            },
                            icon: const Icon(Icons.close, color: Colors.purple),
                          ),
                      ],
                    ),
                  ),
                ),
                const Text(" - "),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white70,
                      elevation: 0.5,
                    ),
                    onPressed: () async {
                      //Mostrar el selector de fecha de inicio
                      final fecha = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      //Si la fecha es null, no se selecciono una fecha
                      if (fecha != null) {
                        setState(() {
                          fechaFinal = fecha;
                        });
                      }
                    },
                    //Icono, texto y boton para cerrar
                    child: Row(
                      mainAxisAlignment: fechaFinal == null
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.calendar_today),
                        Text(
                          fechaFinal == null
                              ? "Fecha final"
                              : '${fechaFinal!.day}/${fechaFinal!.month}/${fechaFinal!.year}',
                          style: const TextStyle(color: Colors.black),
                        ),
                        if (fechaFinal != null)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                fechaFinal = null;
                              });
                            },
                            icon: const Icon(Icons.close),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                //Dos textbutton que muestran la cedula de la persona
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.purple,
                      elevation: 1,
                    ),
                    onPressed: () async {
                      //Mostrar el modal de busqueda de personas
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

                      //Si la persona es null, no se selecciono una persona
                      if (persona != null) {
                        setState(() {
                          paciente = persona;
                        });
                      }
                    },
                    //Mostrar texto de cedula y boton para borrar
                    child: Row(
                      mainAxisAlignment: paciente == null
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.person, color: Colors.white),
                        Text(
                          paciente?.cedula ?? "Buscar paciente",
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        if (paciente != null)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                paciente = null;
                              });
                            },
                            icon: const Icon(Icons.close, color: Colors.white),
                          ),
                      ],
                    ),
                  ),
                ),
                const Text(" - "),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.purple,
                      elevation: 1,
                    ),
                    onPressed: () async {
                      //Mostrar el modal de busqueda de personas
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

                      //Si la persona es null, no se selecciono una persona
                      if (persona != null) {
                        setState(() {
                          doctor = persona;
                        });
                      }
                    },
                    //Mostrar icono, cedula y boton para borrar
                    child: Row(
                      mainAxisAlignment: doctor == null
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.medical_services, color: Colors.white),
                        Text(
                          doctor?.cedula ?? "Buscar doctor",
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        if (doctor != null)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                doctor = null;
                              });
                            },
                            icon: const Icon(Icons.close, color: Colors.white),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<Reserva> reservas) {
    return ListView.builder(
      itemCount: reservas.length,
      itemBuilder: (context, index) {
        final reserva = reservas[index];
        return ListTile(
          leading: const Icon(Icons.calendar_month),
          title: Text(
              '${reserva.fecha.day}/${reserva.fecha.month}/${reserva.fecha.year}'),
          subtitle: Text(
              '${reserva.doctor.nombre} ${reserva.doctor.apellido} - ${reserva.doctor.cedula}'),
          onTap: () {
            Navigator.of(context).pop(reserva);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final reservas = ref
        .watch(reservasProvider.notifier)
        .searchReservas(paciente, doctor, fechaInicio, fechaFinal);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar reserva"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildSearchBar(),
          const SizedBox(height: 20),
          Expanded(
            child: _buildList(reservas),
          ),
        ],
      ),
    );
  }
}
