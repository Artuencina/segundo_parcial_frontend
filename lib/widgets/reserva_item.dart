//Widget para mostrar las reservas en una card que muestra la fecha, la hora y el nombre del paciente. Y que al tocar muestre los demás datos de la reserva además del botón de eliminar.

import 'package:flutter/material.dart';
import 'package:registro_pacientes/models/reserva.dart';

class ReservaItem extends StatelessWidget {
  const ReservaItem({
    super.key,
    required this.reserva,
    required this.mainColor,
    required this.onDelete,
  });

  final Color mainColor;
  final Reserva reserva;
  final void Function(Reserva) onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(reserva.idReserva),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 10),
        margin: const EdgeInsets.fromLTRB(
          0,
          5,
          10,
          5,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      onDismissed: (direction) {
        onDelete(reserva);
      },
      child: Card(
        color: mainColor,
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              //Mostrar la fecha y la hora
              Text(
                "Reserva",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_today, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    '${reserva.fecha.day}/${reserva.fecha.month}/${reserva.fecha.year}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const Spacer(),
                  const Icon(Icons.timer, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    reserva.horario,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              //Mostrar el nombre del paciente y el doctor
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    '${reserva.persona.nombre} ${reserva.persona.apellido}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const Spacer(),
                  const Icon(Icons.medication, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    '${reserva.doctor.nombre} ${reserva.doctor.apellido}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
