import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:registro_pacientes/models/ficha.dart';

Widget paddedText(
  final String text, {
  final TextAlign textAlign = TextAlign.left,
}) =>
    Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11),
        textAlign: textAlign,
      ),
    );

Future<Uint8List> makePdf(List<Ficha> fichas) async {
  final pdf = Document(
    title: 'Fichas',
  );

  final logo = MemoryImage(
      (await rootBundle.load('assets/img/IPSlogo.png')).buffer.asUint8List());

  pdf.addPage(Page(
    pageFormat: PdfPageFormat.a4,
    orientation: PageOrientation.portrait,
    build: (context) {
      return Column(children: [
        SizedBox(height: 150, width: 150, child: Image(logo)),
        Text(
          'Fichas',
          style: const TextStyle(fontSize: 24),
        ),

        //Espaciado
        SizedBox(height: 20),
        Expanded(
          child: Table(
            border: TableBorder.all(
              color: PdfColors.black,
            ),
            children: [
              //Headers
              TableRow(
                children: [
                  paddedText('Fecha'),
                  paddedText('Paciente'),
                  paddedText('Doctor'),
                  paddedText('Motivo'),
                  paddedText('Diagnostico'),
                  paddedText('Categoria'),
                  paddedText('Horario'),
                ],
              ),

              //Fichas
              for (final ficha in fichas)
                TableRow(
                  children: [
                    paddedText(
                        '${ficha.fecha.day}/${ficha.fecha.month}/${ficha.fecha.year}'),
                    paddedText(
                        '${ficha.paciente.nombre} ${ficha.paciente.apellido}'),
                    paddedText(
                        '${ficha.doctor.nombre} ${ficha.doctor.apellido}'),
                    paddedText(ficha.motivo),
                    paddedText(ficha.diagnostico),
                    paddedText(ficha.categoria.descripcion),
                    paddedText(ficha.horario),
                  ],
                ),

              //Mostrar la cantidad total de fichas
              TableRow(
                children: [
                  paddedText('Total: ${fichas.length}'),
                  paddedText(''),
                  paddedText(''),
                  paddedText(''),
                  paddedText(''),
                  paddedText(''),
                  paddedText(''),
                ],
              ),
            ],
          ),
        ),
        //Al fondo de la pagina, poner agradecimentos en texto
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            'Gracias por confiar en nosotros',
            textAlign: TextAlign.center,
          ),
        ),
      ]);
    },
  ));

  return pdf.save();
}
