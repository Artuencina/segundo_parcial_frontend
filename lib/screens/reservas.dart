import 'package:flutter/material.dart';
import 'package:registro_pacientes/models/reserva.dart';

class ReservasScreen extends StatefulWidget {
  const ReservasScreen({
    super.key,
    required this.reservas,
    required this.color,
  });

  final List<Reserva> reservas;
  final Color color;

  @override
  State<ReservasScreen> createState() => _ReservasScreenState();
}

class _ReservasScreenState extends State<ReservasScreen> {
  DateTime fechaFinal = DateTime.now();

  //Metodos
  void _addReserva(Reserva reserva) {
    setState(() {
      widget.reservas.add(reserva);
    });
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      showCloseIcon: true,
      content: Text('Reserva agregada'),
    ));
  }

  void _deleteReserva(Reserva reserva) {
    //Indice para hacer undo
    final index = widget.reservas.indexOf(reserva);

    setState(() {
      widget.reservas
          .removeWhere((element) => element.idReserva == reserva.idReserva);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: const Text('Reserva eliminada'),
          action: SnackBarAction(
            label: "Deshacer",
            onPressed: () {
              setState(() {
                widget.reservas.insert(index, reserva);
              });
            },
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: widget.color,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
