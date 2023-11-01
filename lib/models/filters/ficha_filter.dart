import 'package:registro_pacientes/models/categoria.dart';
import 'package:registro_pacientes/models/persona.dart';

class FichaFilter {
  List<Persona> pacientes = [];
  List<Persona> doctores = [];
  List<Categoria> categorias = [];
  DateTime? fechaInicio;
  DateTime? fechaFin;

  FichaFilter({
    this.pacientes = const [],
    this.doctores = const [],
    this.categorias = const [],
    this.fechaInicio,
    this.fechaFin,
  });
}
