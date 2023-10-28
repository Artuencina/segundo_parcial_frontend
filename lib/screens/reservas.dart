import 'package:flutter/material.dart';
import 'package:registro_pacientes/models/persona.dart';
import 'package:registro_pacientes/models/reserva.dart';
import 'package:registro_pacientes/widgets/reserva_item.dart';

//Esta parte se tiene que hacer con providers pero mientras
//voy a establecer estaticamente las personas y doctores
final pacientes = [
  Persona(
    nombre: "Juan",
    telefono: "12345678",
    apellido: 'Perez',
    cedula: '12345678',
    email: '',
    esDoctor: false,
  ),
  Persona(
    nombre: "Pedro",
    telefono: "12345678",
    apellido: 'Perez',
    cedula: '12345678',
    email: '',
    esDoctor: false,
  ),
];

List<Persona> doctores = [
  Persona(
    nombre: "Roberto",
    telefono: "12345678",
    apellido: 'Perez',
    cedula: '12345678',
    email: '',
    esDoctor: true,
  ),
  Persona(
    nombre: "Luis",
    telefono: "12345678",
    apellido: 'Perez',
    cedula: '12345678',
    email: '',
    esDoctor: true,
  ),
];

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

  //Funcion para mostrar un modal para agregar una reserva
  void _showModalReserva() {
    //Modal que permita elegir una persona, un doctor, una fecha y una hora
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(10),
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
                items: pacientes
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.nombre),
                      ),
                    )
                    .toList(),
                onChanged: (value) {},
              ),

              const SizedBox(height: 10),
              //Elegir doctor
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Doctor",
                  border: OutlineInputBorder(),
                ),
                items: doctores
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.nombre),
                      ),
                    )
                    .toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 10),
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

                  //Actualizar el estado de la fecha
                  setState(() {
                    widget
                        .reservas[widget.reservas.indexWhere(
                      (element) => element.fecha == fecha,
                    )]
                        .fecha = fecha!;
                  });
                },
                child: const Text("Elegir fecha"),
              ),
              const SizedBox(height: 10),
              //Elegir hora con un picker de hora
              //y luego asignar en el horario
              //de la reserva
              ElevatedButton(
                onPressed: () async {
                  //Mostrar el timepicker
                  final hora = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  //Actualizar el estado de la hora
                  setState(() {
                    widget
                        .reservas[widget.reservas.indexWhere(
                      (element) => element.horario == hora!.format(context),
                    )]
                        .horario = hora!.format(context);
                  });
                },
                child: const Text("Elegir hora"),
              ),
            ],
          ),
        );
      },
    );
  }

  //Funcion que valida que la fecha y hora ingresada no exista entre las reservas
  String _validarReserva(Reserva reserva) {
    String respuesta = "";
    //Validar que la fecha no exista
    for (final reserva in widget.reservas) {
      if (reserva.fecha == reserva.fecha &&
          reserva.horario == reserva.horario) {
        respuesta = "Ya existe una reserva para esa fecha y hora";
        break;
      }
    }
    return respuesta;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showModalReserva,
        backgroundColor: widget.color,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: widget.reservas.length,
        itemBuilder: (context, index) {
          return ReservaItem(
            reserva: widget.reservas[index],
            mainColor: widget.color,
          );
        },
      ),
    );
  }
}
