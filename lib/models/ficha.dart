import 'package:registro_pacientes/models/categoria.dart';
import 'package:registro_pacientes/models/persona.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Ficha {
  String idFicha;
  String diagnostico;
  String motivo;
  DateTime fecha;
  String horario;
  Categoria categoria;
  Persona doctor;
  Persona paciente;

  Ficha({
    required this.diagnostico,
    required this.motivo,
    required this.fecha,
    required this.horario,
    required this.categoria,
    required this.doctor,
    required this.paciente,
  }) : idFicha = uuid.v4();
}
