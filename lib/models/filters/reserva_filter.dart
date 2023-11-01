import 'package:registro_pacientes/models/persona.dart';

class ReservaFilter {
  Persona? paciente;
  Persona? doctor;
  DateTime? fechaInicio;
  DateTime? fechaFin;

  ReservaFilter({
    this.paciente,
    this.doctor,
    this.fechaInicio,
    this.fechaFin,
  });
}
