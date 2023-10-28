import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/persona.dart';
import 'package:registro_pacientes/models/reserva.dart';
import 'package:registro_pacientes/providers/personas_provider.dart';
import 'package:registro_pacientes/providers/reservas_provider.dart';
import 'package:registro_pacientes/widgets/reserva_item.dart';

class ReservasScreen extends ConsumerStatefulWidget {
  const ReservasScreen({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  ConsumerState<ReservasScreen> createState() => _ReservasScreenState();
}

class _ReservasScreenState extends ConsumerState<ReservasScreen> {
  DateTime fechaFinal = DateTime.now();

  //Metodos
  void _addReserva(Reserva reserva) {
    //Agregar la reserva a la lista
    ref.read(reservasProvider.notifier).addReserva(reserva);
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      showCloseIcon: true,
      content: Text('Reserva agregada'),
    ));
  }

  void _deleteReserva(Reserva reserva) {
    final index = ref.read(reservasProvider).indexWhere(
          (element) => element.idReserva == reserva.idReserva,
        );

    //Eliminar la reserva
    ref.read(reservasProvider.notifier).removeReserva(reserva);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: const Text('Reserva eliminada'),
          action: SnackBarAction(
            label: "Deshacer",
            onPressed: () {
              ref.read(reservasProvider.notifier).insertReserva(index, reserva);
            },
          )),
    );
  }

  //Funcion para mostrar un modal para agregar una reserva
  void _showModalReserva() {
    //Modal que permita elegir una persona, un doctor, una fecha y una hora

    Persona? pacienteSeleccionado;
    Persona? doctorSeleccionado;
    DateTime fechaSeleccionada = DateTime.now();
    String horarioSeleccionado = '';

    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
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
              //Elegir persona
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Persona",
                  border: OutlineInputBorder(),
                ),
                items: ref
                    .read(personasProvider)
                    .where(
                      (element) => element.esDoctor == false,
                    )
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.nombre),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  pacienteSeleccionado = value as Persona;
                },
              ),

              const SizedBox(height: 10),
              //Elegir doctor
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Doctor",
                  border: OutlineInputBorder(),
                ),
                items: ref
                    .read(personasProvider)
                    .where(
                      (element) => element.esDoctor == true,
                    )
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.nombre),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  doctorSeleccionado = value as Persona;
                },
              ),
              const SizedBox(height: 10),
              //Mostrar la fecha seleccionada

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
                    fechaSeleccionada = fecha;
                  }
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
                      final valido = _validarReserva(
                          pacienteSeleccionado,
                          doctorSeleccionado,
                          fechaSeleccionada,
                          horarioSeleccionado);

                      if (valido.isNotEmpty) {
                        //Mostrar mensaje de error
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(valido),
                            backgroundColor: Colors.red,
                          ),
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
                      _addReserva(reserva);
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
      },
    );
  }

  //Funcion que valida que la fecha y hora ingresada no exista entre las reservas
  String _validarReserva(
      Persona? paciente, Persona? doctor, DateTime fecha, String horario) {
    //Validar que se seleccionó un paciente
    if (paciente == null) {
      return "Debe seleccionar un paciente";
    }

    //Validar que se seleccionó un doctor
    if (doctor == null) {
      return "Debe seleccionar un doctor";
    }

    if (horario.isEmpty) {
      return "Debe seleccionar un horario";
    }

    //Validar que no exista un horario para esa fecha
    final reservas = ref.read(reservasProvider);

    final existeReserva = reservas.any((element) {
      return element.fecha == fecha && element.horario == horario;
    });

    if (existeReserva) {
      return "Ya existe una reserva para ese horario";
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    final reservas = ref.watch(reservasProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showModalReserva,
        backgroundColor: widget.color,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: reservas.length,
        itemBuilder: (context, index) {
          return ReservaItem(
            reserva: reservas[index],
            mainColor: widget.color,
          );
        },
      ),
    );
  }
}
