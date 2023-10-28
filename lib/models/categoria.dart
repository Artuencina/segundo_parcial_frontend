import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Categoria {
  Categoria({
    required this.descripcion,
  }) : idCategoria = uuid.v4();

  String idCategoria;
  String descripcion;
}
