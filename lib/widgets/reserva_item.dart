//Widget para mostrar las reservas en una card que muestra la fecha, la hora y el nombre del paciente. Y que al tocar muestre los demás datos de la reserva además del botón de eliminar.

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:registro_pacientes/models/reserva.dart';

class ReservaItem extends StatelessWidget {
  const ReservaItem({
    super.key,
    required this.reserva,
    required this.mainColor,
  });

  final Color mainColor;
  final Reserva reserva;

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      fill: Fill.fillBack,
      direction: FlipDirection.HORIZONTAL,
      side: CardSide.FRONT,
      front: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: mainColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(Icons.calendar_today),
            Text(reserva.fecha.toString()),
            const Icon(Icons.timer),
            Text(reserva.fecha.hour.toString()),
          ],
        ),
      ),
      back: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: mainColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(Icons.person),
            Text(reserva.persona.nombre),
            const Icon(Icons.phone),
            Text(reserva.persona.telefono),
          ],
        ),
      ),
    );
  }
}
