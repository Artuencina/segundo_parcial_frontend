import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_pacientes/models/categoria.dart';
import 'package:registro_pacientes/models/ficha.dart';
import 'package:registro_pacientes/models/persona.dart';
import 'package:registro_pacientes/models/reserva.dart';
import 'package:registro_pacientes/providers/categorias_provider.dart';
import 'package:registro_pacientes/providers/personas_provider.dart';
import 'package:registro_pacientes/providers/reservas_provider.dart';

class ModalFicha extends ConsumerStatefulWidget {
  const ModalFicha({
    super.key,
    required this.mainColor,
    required this.addFicha,
    this.reserva,
  });

  final Color mainColor;
  final void Function(Ficha) addFicha;
  final Reserva?
      reserva; //Este valor es por si se quiere agregar una ficha con reserva

  @override
  ConsumerState<ModalFicha> createState() => _ModalFichaState();
}

class _ModalFichaState extends ConsumerState<ModalFicha> {
  DateTime fechaSeleccionada = DateTime.now();
  Persona? doctorSeleccionado;
  Persona? pacienteSeleccionado;
  String? horarioSeleccionado;
  Categoria? categoriaSeleccionada;

  //Controllers
  final motivoController = TextEditingController();
  final diagnosticoController = TextEditingController();

  //Modal que permite elegir Doctor (dropdown), Paciente (dropdown), Fecha (datepicker), Horario(dropdown), Motivo (text), Diagnostico (Textarea), y categoria (dropdown)
  @override
  Widget build(BuildContext context) {
    //Si reserva no es null, establecer los datos de la ficha y deshabilitar los campos
    if (widget.reserva != null) {
      //Establecer los datos de la ficha
      fechaSeleccionada = widget.reserva!.fecha;
      horarioSeleccionado = widget.reserva!.horario;
      doctorSeleccionado = widget.reserva!.doctor;
      pacienteSeleccionado = widget.reserva!.persona;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Mostrar en rows para ahorrar espacio
          //Titulo
          const Text(
            "Agregar Ficha",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Motivo",
              border: OutlineInputBorder(),
            ),
            controller: motivoController,
          ),
          //Textarea para diagnostico
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "Diagnostico",
              border: OutlineInputBorder(),
            ),
            controller: diagnosticoController,
          ),
          const SizedBox(
            height: 20,
          ),
          //Row para categoria y fecha
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Categoria
              Expanded(
                child: DropdownButtonFormField<Categoria>(
                  decoration: const InputDecoration(
                    labelText: "Categoria",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null ? "Requerido" : null,
                  value: categoriaSeleccionada,
                  onChanged: (value) {
                    setState(() {
                      categoriaSeleccionada = value;
                    });
                  },
                  items: ref
                      .read(categoriasProvider)
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.descripcion),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              //Fecha
              Expanded(
                //Textfield que muestra la fecha seleccionada
                //y al hacer tap abre un datepicker
                child: InkWell(
                  onTap: () async {
                    //Si reserva no es null, no permitir cambiar la fecha
                    if (widget.reserva != null) {
                      return;
                    }
                    //Mostrar datepicker
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );

                    //Si se selecciono una fecha
                    if (date != null) {
                      //Cambiar el estado de la fecha
                      setState(() {
                        fechaSeleccionada = date;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: "Fecha",
                      border: OutlineInputBorder(),
                    ),
                    child: Text(
                      "${fechaSeleccionada.day}/${fechaSeleccionada.month}/${fechaSeleccionada.year}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          //Doctor

          IgnorePointer(
            ignoring: widget.reserva != null,
            child: DropdownButtonFormField<Persona>(
              decoration: const InputDecoration(
                labelText: "Doctor",
                border: OutlineInputBorder(),
              ),
              value: doctorSeleccionado,
              onChanged: (value) {
                setState(() {
                  doctorSeleccionado = value;
                });
              },
              items: ref
                  .read(personasProvider.notifier)
                  .doctores
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text('${e.nombre} ${e.apellido}'),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //Paciente
          IgnorePointer(
            ignoring: widget.reserva != null,
            child: DropdownButtonFormField<Persona>(
              decoration: const InputDecoration(
                labelText: "Paciente",
                border: OutlineInputBorder(),
              ),
              value: pacienteSeleccionado,
              onChanged: (value) {
                setState(() {
                  pacienteSeleccionado = value;
                });
              },
              items: ref
                  .read(personasProvider.notifier)
                  .pacientes
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text('${e.nombre} ${e.apellido}'),
                    ),
                  )
                  .toList(),
            ),
          ),

          //Dropdown para horario
          const SizedBox(
            height: 20,
          ),
          IgnorePointer(
            ignoring: widget.reserva != null,
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Horario",
                border: OutlineInputBorder(),
              ),
              value: horarioSeleccionado,
              onChanged: (value) {
                setState(() {
                  horarioSeleccionado = value;
                });
              },
              items: horarios
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
            ),
          ),
          //Textfield para motivo

          const SizedBox(
            height: 20,
          ),
          //Row para botones
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Boton para agregar

              ElevatedButton(
                onPressed: () {
                  //Validar que todos los campos esten llenos
                  if (categoriaSeleccionada == null ||
                      doctorSeleccionado == null ||
                      pacienteSeleccionado == null ||
                      horarioSeleccionado == null ||
                      motivoController.text.isEmpty ||
                      diagnosticoController.text.isEmpty) {
                    //Mostrar alerta de error
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: const Text(
                              "Todos los campos son requeridos para agregar una ficha"),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Ok"),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }

                  //Crear la ficha
                  final ficha = Ficha(
                    categoria: categoriaSeleccionada!,
                    doctor: doctorSeleccionado!,
                    paciente: pacienteSeleccionado!,
                    diagnostico: diagnosticoController.text,
                    motivo: motivoController.text,
                    horario: horarioSeleccionado!,
                    fecha: fechaSeleccionada,
                  );

                  //Agregar la ficha
                  widget.addFicha(ficha);

                  //Si reserva no es nulo, eliminarlo
                  if (widget.reserva != null) {
                    ref.read(reservasProvider.notifier).removeReserva(
                          widget.reserva!,
                        );
                  }
                },
                child: const Text("Agregar"),
              ),
              //Boton para cancelar
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar"),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
