import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/ficha.dart';
import 'package:registro_pacientes/models/reserva.dart';
import 'package:registro_pacientes/providers/fichas_provider.dart';
import 'package:registro_pacientes/providers/reservas_provider.dart';
import 'package:registro_pacientes/widgets/ficha_item.dart';
import 'package:registro_pacientes/widgets/new_ficha.dart';

class FichasScreen extends ConsumerStatefulWidget {
  const FichasScreen({
    super.key,
    required this.mainColor,
  });

  final Color mainColor;
  @override
  ConsumerState<FichasScreen> createState() => _FichasScreenState();
}

class _FichasScreenState extends ConsumerState<FichasScreen> {
  //Metodos
  void _deleteFicha(Ficha ficha) {
    //Eliminar ficha
    ref.read(fichasProvider.notifier).deleteFicha(ficha);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Ficha eliminada"),
        action: SnackBarAction(
          label: "Deshacer",
          onPressed: () {
            ref.read(fichasProvider.notifier).addFicha(ficha);
          },
        ),
      ),
    );
  }

  //Metodo para agregar una ficha
  void _addFicha(Ficha ficha) {
    //Agregar ficha al estado
    ref.read(fichasProvider.notifier).addFicha(ficha);

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        showCloseIcon: true,
        content: Text("Ficha agregada"),
      ),
    );
  }

  //Metodo para mostrar el modal para agregar una ficha sin reserva
  void _showModalFicha(Reserva? reserva) {
    //Si reserva no es null, abrir el buscador de reservas
    if (reserva != null) {}

    //Mostrar el modal para agregar una ficha
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ModalFicha(
          mainColor: widget.mainColor,
          addFicha: _addFicha,
          reserva: reserva,
        );
      },
    );
  }

  //Build

  @override
  Widget build(BuildContext context) {
    final fichas = ref.watch(fichasProvider);

    return Scaffold(
      //Mostrar dos floating action buttons
      //Uno es para agregar uno nuevo
      //Y otro es para crear a partir de una reserva
      //Al final hacen lo mismo pero el de la reserva
      //estira los datos de la reserva
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              //Mostrar el dialogo para agregar una ficha
              _showModalFicha(ref.read(reservasProvider).first);
            },
            backgroundColor: widget.mainColor,
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
            child: const Icon(Icons.calendar_month),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              //Mostrar el modal para agregar una ficha
              _showModalFicha(null);
            },
            backgroundColor: widget.mainColor,
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: fichas.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_copy_outlined,
                    size: 100,
                    color: widget.mainColor,
                  ),
                  const SizedBox(height: 10),
                  const Text("No hay fichas"),
                ],
              ),
            )
          : ListView.builder(
              itemCount: fichas.length,
              itemBuilder: (context, index) {
                return FichaItem(
                  mainColor: widget.mainColor,
                  ficha: fichas[index],
                  deleteFicha: _deleteFicha,
                );
              },
            ),
    );
  }
}
