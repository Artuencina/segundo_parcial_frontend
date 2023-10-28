import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Persona {
  Persona({
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.email,
    required this.cedula,
    required this.esDoctor,
  }) : idPersona = uuid.v4();
  String idPersona;
  String nombre;
  String apellido;
  String telefono;
  String email;
  String cedula;
  bool esDoctor;
}
