import 'package:registro_pacientes/models/categoria.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Ficha {
  String idFicha;
  String diagnostico;
  String motivo;
  Categoria categoria;

  Ficha({
    required this.diagnostico,
    required this.motivo,
    required this.categoria,
  }) : idFicha = uuid.v4();
}
