import 'package:flutter/material.dart';
import 'package:registro_pacientes/models/filters/persona_filter.dart';

class PersonaFilterScreen extends StatefulWidget {
  const PersonaFilterScreen({
    super.key,
    required this.mainColor,
    required this.personaFilter,
  });

  final Color mainColor;
  final PersonaFilter personaFilter;
  @override
  State<PersonaFilterScreen> createState() => _PersonaFilterScreenState();
}

class _PersonaFilterScreenState extends State<PersonaFilterScreen> {
  //Filtros
  final _cedulaController = TextEditingController();
  final _nombreController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _correoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //Cargar los datos del filtro
    _cedulaController.text = widget.personaFilter.cedula;
    _nombreController.text = widget.personaFilter.nombreApellido;
    _telefonoController.text = widget.personaFilter.telefono;
    _correoController.text = widget.personaFilter.email;
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
              //Rertornar el filtro
              final filtro = PersonaFilter(
                cedula: _cedulaController.text,
                nombreApellido: _nombreController.text,
                telefono: _telefonoController.text,
                email: _correoController.text,
                esDoctor: widget.personaFilter.esDoctor,
              );
              Navigator.of(context).pop(filtro);
            },
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Cedula
              Text('Cedula', style: Theme.of(context).textTheme.titleLarge),
              TextField(
                controller: _cedulaController,
                maxLength: 12,
                onTapOutside: (event) =>
                    {_cedulaController.text = _cedulaController.text.trim()},
                decoration: InputDecoration(
                  hintText: 'Cedula',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _cedulaController.clear();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Divider(),
              //Nombre
              Text('Nombre', style: Theme.of(context).textTheme.titleLarge),
              TextField(
                controller: _nombreController,
                onTapOutside: (event) =>
                    {_nombreController.text = _nombreController.text.trim()},
                decoration: InputDecoration(
                  hintText: 'Nombre',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _nombreController.clear();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Divider(),
              //Telefono
              Text('Telefono', style: Theme.of(context).textTheme.titleLarge),
              TextField(
                controller: _telefonoController,
                maxLength: 10,
                onTapOutside: (event) => {
                  _telefonoController.text = _telefonoController.text.trim()
                },
                decoration: InputDecoration(
                  hintText: 'Telefono',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _telefonoController.clear();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Divider(),
              //Correo
              Text('Correo', style: Theme.of(context).textTheme.titleLarge),
              TextField(
                controller: _correoController,
                onTapOutside: (event) =>
                    {_correoController.text = _correoController.text.trim()},
                decoration: InputDecoration(
                  hintText: 'Correo',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _correoController.clear();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
