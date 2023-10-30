import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/persona.dart';
import 'package:registro_pacientes/models/reserva.dart';
import 'package:registro_pacientes/providers/reservas_provider.dart';
import 'package:registro_pacientes/widgets/new_reserva.dart';
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

    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ModalReserva(
          addReserva: _addReserva,
          validarReserva: _validarReserva,
          color: widget.color,
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
      body: reservas.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, size: 100, color: widget.color),
                  const SizedBox(height: 10),
                  const Text("No hay reservas"),
                ],
              ),
            )
          : ListView.builder(
              itemCount: reservas.length,
              itemBuilder: (context, index) {
                return ReservaItem(
                  reserva: reservas[index],
                  mainColor: widget.color,
                  onDelete: _deleteReserva,
                );
              },
            ),
    );
  }
}
