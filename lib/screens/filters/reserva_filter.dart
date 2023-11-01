import 'package:flutter/material.dart';
import 'package:registro_pacientes/models/filters/reserva_filter.dart';
import 'package:registro_pacientes/models/persona.dart';
import 'package:registro_pacientes/widgets/persona_search.dart';

class ReservaFilterScreen extends StatefulWidget {
  const ReservaFilterScreen({
    super.key,
    required this.mainColor,
    required this.reservaFilter,
  });

  final Color mainColor;
  final ReservaFilter reservaFilter;
  @override
  State<ReservaFilterScreen> createState() => _ReservaFilterScreenState();
}

class _ReservaFilterScreenState extends State<ReservaFilterScreen> {
  //Filtros
  Persona? paciente;
  Persona? doctor;
  DateTime? fechaInicio;
  DateTime? fechaFin;

  @override
  void initState() {
    super.initState();
    paciente = widget.reservaFilter.paciente;
    doctor = widget.reservaFilter.doctor;
    fechaInicio = widget.reservaFilter.fechaInicio;
    fechaFin = widget.reservaFilter.fechaFin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.mainColor,
        title: Text(
          'Filtros',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: () {
              final filtro = ReservaFilter(
                paciente: paciente,
                doctor: doctor,
                fechaInicio: fechaInicio,
                fechaFin: fechaFin,
              );
              Navigator.of(context).pop(filtro);
            },
          ),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Paciente',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: widget.mainColor,
                  ),
                  onPressed: () async {
                    final paciente = await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const ModalSearchPersona(
                          buscarPacientes: true,
                        );
                      },
                    );
                    setState(
                      () {
                        this.paciente = paciente;
                      },
                    );
                  },
                  //Icono de busqueda, texto con nombre y apellido e iconbutton para limpiar
                  child: Row(
                    mainAxisAlignment: paciente == null
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.search, color: Colors.white),
                      if (paciente != null)
                        Text(
                          '${paciente!.nombre} ${paciente!.apellido}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      if (paciente != null)
                        IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              paciente = null;
                            });
                          },
                        ),
                    ],
                  ),
                )
              ],
            ),
            //Doctor
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Doctor',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: widget.mainColor,
                  ),
                  onPressed: () async {
                    final doctor = await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const ModalSearchPersona(
                          buscarPacientes: false,
                        );
                      },
                    );
                    setState(
                      () {
                        this.doctor = doctor;
                      },
                    );
                  },
                  //Icono de busqueda, texto con nombre y apellido e iconbutton para limpiar
                  child: Row(
                    mainAxisAlignment: doctor == null
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.search, color: Colors.white),
                      if (doctor != null)
                        Text(
                          '${doctor!.nombre} ${doctor!.apellido}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      if (doctor != null)
                        IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              doctor = null;
                            });
                          },
                        ),
                    ],
                  ),
                )
              ],
            ),
            //Fecha de inicio
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fecha de inicio',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: widget.mainColor,
                  ),
                  onPressed: () async {
                    final fechaInicio = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    setState(
                      () {
                        this.fechaInicio = fechaInicio;
                      },
                    );
                  },
                  //Icono de busqueda, texto con nombre y apellido e iconbutton para limpiar
                  child: Row(
                    mainAxisAlignment: fechaInicio == null
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.white),
                      if (fechaInicio != null)
                        Text(
                          '${fechaInicio!.day}/${fechaInicio!.month}/${fechaInicio!.year}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      if (fechaInicio != null)
                        IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white),
                          onPressed: () {
                            setState(() => fechaInicio = null);
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
            //Fecha de fin
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fecha de fin',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: widget.mainColor,
                  ),
                  onPressed: () async {
                    final fechaFin = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    setState(
                      () {
                        this.fechaFin = fechaFin;
                      },
                    );
                  },
                  //Icono de busqueda, texto con nombre y apellido e iconbutton para limpiar
                  child: Row(
                    mainAxisAlignment: fechaFin == null
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.white),
                      if (fechaFin != null)
                        Text(
                          '${fechaFin!.day}/${fechaFin!.month}/${fechaFin!.year}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      if (fechaFin != null)
                        IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white),
                          onPressed: () {
                            setState(() => fechaFin = null);
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
