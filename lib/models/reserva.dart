import 'package:registro_pacientes/models/persona.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Reserva {
  String idReserva;
  Persona persona;
  Persona doctor;
  DateTime fecha;
  String horario;

  Reserva({
    required this.persona,
    required this.doctor,
    required this.fecha,
    required this.horario,
  }) : idReserva = uuid.v4();
}

//Listado base de fechas de cada hora, una lista
//de 9hs a 21hs
const horarios = [
  '09:00 a 10:00',
  '10:00 a 11:00',
  '11:00 a 12:00',
  '12:00 a 13:00',
  '13:00 a 14:00',
  '14:00 a 15:00',
  '15:00 a 16:00',
  '16:00 a 17:00',
  '17:00 a 18:00',
  '18:00 a 19:00',
  '19:00 a 20:00',
  '20:00 a 21:00',
];
