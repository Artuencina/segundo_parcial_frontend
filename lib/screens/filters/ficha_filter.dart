import 'package:flutter/material.dart';
import 'package:registro_pacientes/models/categoria.dart';
import 'package:registro_pacientes/models/filters/ficha_filter.dart';
import 'package:registro_pacientes/models/persona.dart';
import 'package:registro_pacientes/widgets/categoria_search.dart';
import 'package:registro_pacientes/widgets/persona_search.dart';

class FichaFilterScreen extends StatefulWidget {
  const FichaFilterScreen({
    super.key,
    required this.mainColor,
    required this.filter,
  });

  final Color mainColor;
  final FichaFilter filter;
  @override
  State<FichaFilterScreen> createState() => _FichaFilterScreenState();
}

class _FichaFilterScreenState extends State<FichaFilterScreen> {
  //Filtros
  final List<Persona> pacientes = [];
  final List<Persona> doctores = [];
  final List<Categoria> categorias = [];
  DateTime? fechaInicio;
  DateTime? fechaFin;

  @override
  void initState() {
    super.initState();

    //Cargar los filtros
    pacientes.addAll(widget.filter.pacientes);
    doctores.addAll(widget.filter.doctores);
    categorias.addAll(widget.filter.categorias);
    fechaInicio = widget.filter.fechaInicio;
    fechaFin = widget.filter.fechaFin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.mainColor,
        title: Text(
          "Filtros",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //Retornar un filtro
              final filtro = FichaFilter(
                pacientes: pacientes,
                doctores: doctores,
                categorias: categorias,
                fechaInicio: fechaInicio,
                fechaFin: fechaFin,
              );
              Navigator.of(context).pop(filtro);
            },
            icon: const Icon(Icons.save, color: Colors.white),
          ),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Pacientes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Pacientes",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //Boton de busqueda de pacientes que agrega
                  //y abajo un filter clip con un icono de cerrar
                  //para eliminar el paciente
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Buscar paciente",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    //Color del boton
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.mainColor,
                    ),
                    onPressed: () async {
                      //Mostrar un dialogo para buscar pacientes
                      //y agregarlos a la lista de pacientes
                      final persona = await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const ModalSearchPersona(
                            buscarPacientes: true,
                          );
                        },
                      );

                      //Agregar a la lista de personas y actualizar el dialogo
                      if (persona != null) {
                        setState(() {
                          pacientes.add(persona);
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              //Container que muestra una lista de filter chips con un icono de cerrar para eliminar
              //el paciente
              pacientes.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      constraints: const BoxConstraints.expand(height: 50),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: pacientes.length,
                        itemBuilder: (context, index) {
                          final paciente = pacientes[index];
                          return Chip(
                            padding: const EdgeInsets.all(4),
                            label:
                                Text('${paciente.nombre} ${paciente.apellido}'),
                            onDeleted: () {
                              setState(() {
                                pacientes.removeAt(index);
                              });
                            },
                          );
                        },
                      ),
                    )
                  : const SizedBox(height: 10),
              //Separador
              const Divider(),
              //Doctores
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Doctores",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //Boton de busqueda de doctores que agrega
                  //y abajo un filter clip con un icono de cerrar
                  //para eliminar el doctor
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Buscar doctor",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    //Color del boton
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.mainColor,
                    ),
                    onPressed: () async {
                      //Mostrar un dialogo para buscar doctores
                      //y agregarlos a la lista de doctores
                      final persona = await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const ModalSearchPersona(
                            buscarPacientes: false,
                          );
                        },
                      );

                      //Agregar a la lista de personas y actualizar el dialogo
                      if (persona != null) {
                        setState(() {
                          doctores.add(persona);
                        });
                      }
                    },
                  ),
                ],
              ),

              //Container que muestra una lista de filter chips con un icono de cerrar para eliminar
              //el doctor
              doctores.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      constraints: const BoxConstraints.expand(height: 50),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: doctores.length,
                        itemBuilder: (context, index) {
                          final doctor = doctores[index];
                          return Chip(
                            padding: const EdgeInsets.all(4),
                            label: Text('${doctor.nombre} ${doctor.apellido}'),
                            onDeleted: () {
                              setState(() {
                                doctores.removeAt(index);
                              });
                            },
                          );
                        },
                      ),
                    )
                  : const SizedBox(height: 10),
              //Separador
              const Divider(),
              //Categorias
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Categorias",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //Boton de busqueda de categorias que agrega
                  //y abajo un filter clip con un icono de cerrar
                  //para eliminar la categoria
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Buscar categoria",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    //Color del boton
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.mainColor,
                    ),
                    onPressed: () async {
                      //Mostrar un dialogo para buscar categorias
                      //y agregarlos a la lista de categorias
                      final categoria = await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const ModalSearchCategoria();
                        },
                      );

                      //Agregar a la lista de categorias y actualizar el dialogo
                      if (categoria != null) {
                        setState(() {
                          categorias.add(categoria);
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              categorias.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      constraints: const BoxConstraints.expand(height: 50),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categorias.length,
                        itemBuilder: (context, index) {
                          final categoria = categorias[index];
                          return Chip(
                            padding: const EdgeInsets.all(4),
                            label: Text(categoria.descripcion),
                            onDeleted: () {
                              setState(() {
                                categorias.removeAt(index);
                              });
                            },
                          );
                        },
                      ),
                    )
                  : const SizedBox(height: 10),
              //Separador
              const Divider(),

              //Fechas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Fecha de inicio",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextButton(
                    //Outlined
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: widget.mainColor),
                      ),
                    ),

                    onPressed: () async {
                      //Mostrar un dialogo para seleccionar la fecha
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      //Actualizar la fecha de inicio
                      if (date != null) {
                        setState(() {
                          fechaInicio = date;
                        });
                      }
                    },
                    //Row con un icono de calendario, un textbutton y otro boton
                    //para poner nulo
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, color: widget.mainColor),
                        const SizedBox(width: 10),
                        Text(
                          fechaInicio == null
                              ? "Seleccionar fecha"
                              : "${fechaInicio!.day}/${fechaInicio!.month}/${fechaInicio!.year}",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(width: 10),
                        if (fechaInicio != null)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                fechaInicio = null;
                              });
                            },
                            icon: Icon(Icons.close, color: widget.mainColor),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              //Separador
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Fecha de fin",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextButton(
                    //Outlined
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: widget.mainColor),
                      ),
                    ),

                    onPressed: () async {
                      //Mostrar un dialogo para seleccionar la fecha
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      //Actualizar la fecha de fin
                      if (date != null) {
                        setState(() {
                          fechaFin = date;
                        });
                      }
                    },
                    //Row con un icono de calendario, un textbutton y otro boton
                    //para poner nulo
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, color: widget.mainColor),
                        const SizedBox(width: 10),
                        Text(
                          fechaFin == null
                              ? "Seleccionar fecha"
                              : "${fechaFin!.day}/${fechaFin!.month}/${fechaFin!.year}",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(width: 10),
                        if (fechaFin != null)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                fechaFin = null;
                              });
                            },
                            icon: Icon(Icons.close, color: widget.mainColor),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
