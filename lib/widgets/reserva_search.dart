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
  Reserva? reservaSeleccionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar reserva"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop(null);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
