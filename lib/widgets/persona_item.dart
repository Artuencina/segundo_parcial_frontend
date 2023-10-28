import 'package:flutter/material.dart';
import 'package:registro_pacientes/models/persona.dart';

class PersonaItem extends StatelessWidget {
  const PersonaItem({
    super.key,
    required this.icon,
    required this.color,
    required this.persona,
    required this.deletePersona,
    required this.updatePersona,
  });

  final IconData icon;
  final Color color;
  final Persona persona;
  final Function(Persona) deletePersona;
  final Function(Persona) updatePersona;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        deletePersona(persona);
      },
      key: ValueKey(persona.idPersona),
      child: Card(
        color: color,
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              //Propiedades de la persona
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${persona.nombre} ${persona.apellido}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        persona.telefono,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        persona.email,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.perm_identity,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        persona.cedula,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              //Botones para editar y eliminar
              const Spacer(),
              IconButton(
                onPressed: () {
                  updatePersona(persona);
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  deletePersona(persona);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
