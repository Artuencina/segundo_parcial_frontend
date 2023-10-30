import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:registro_pacientes/models/ficha.dart';

class FichaItem extends StatelessWidget {
  const FichaItem({
    super.key,
    required this.mainColor,
    required this.ficha,
    required this.deleteFicha,
  });

  final Color mainColor;
  final Ficha ficha;
  final void Function(Ficha) deleteFicha;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(ficha.idFicha),
      onDismissed: (_) => deleteFicha(ficha),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: FlipCard(
          direction: FlipDirection.HORIZONTAL,
          //En el frente se muestra la informacion basica de la ficha
          //(categoria, fecha, motivo, paciente)
          //Distribuidos en columnas con rows
          front: Card(
            margin: const EdgeInsets.all(10),
            color: mainColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //Mostrar un titulo con la ficha y el id
                  Text(
                    "Ficha",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  //Mostrar la categoria
                  Row(
                    children: [
                      const Icon(Icons.category, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        ficha.categoria.descripcion,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Spacer(),
                      //Fecha
                      const Icon(Icons.calendar_today, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        '${ficha.fecha.day}/${ficha.fecha.month}/${ficha.fecha.year}',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      //Mostrar el horario
                      const Icon(Icons.timer, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        ficha.horario,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),
                  //Mostrar el doctor
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.medical_information_outlined,
                          color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        ficha.doctor.nombre,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  //Mostrar el paciente
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        ficha.paciente.nombre,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        ficha.paciente.apellido,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          //En el dorso se muestra el diagnostico, el doctor y el horario
          back: Card(
            margin: const EdgeInsets.all(10),
            color: mainColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //Mostrar el diagnóstico
                  Text(
                    'Motivo:\n${ficha.motivo}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10),
                  //Mostrar el diagnostico
                  Text(
                    'Diagnostico:\n${ficha.diagnostico}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
