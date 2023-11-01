//Pantalla basica solamente para mostrar el pdf
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:registro_pacientes/models/ficha.dart';
import 'package:registro_pacientes/providers/pdfexport.dart';

class PdfPreviewScreen extends StatelessWidget {
  const PdfPreviewScreen({
    super.key,
    required this.fichas,
  });

  final List<Ficha> fichas;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PDF'),
        ),
        body: PdfPreview(
          canDebug: false,
          canChangeOrientation: false,
          build: (context) => makePdf(fichas),
        ));
  }
}
