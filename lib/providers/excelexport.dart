//Funcion para exportar a excel

import 'package:excel/excel.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:registro_pacientes/models/ficha.dart';

Future<bool> exportExcel(List<Ficha> fichas) async {
  var excel = Excel.createExcel();

  //Eliminar la hoja por defecto
  Sheet sheet = excel['Sheet1'];

  //En la hoja, cargar todos los datos de las fichas
  sheet.appendRow([
    'Fecha',
    'Paciente',
    'Doctor',
    'Motivo',
    'Diagnostico',
    'Categoria',
    'Horario',
  ]);

  for (final ficha in fichas) {
    sheet.appendRow([
      ficha.fecha.toString(),
      '${ficha.paciente.nombre} ${ficha.paciente.apellido}',
      '${ficha.doctor.nombre} ${ficha.doctor.apellido}',
      ficha.motivo,
      ficha.diagnostico,
      ficha.categoria.descripcion,
      ficha.horario,
    ]);
  }

  //Guardar el archivo en la carpeta de descargas
  //del dispositivo

  //Solicitar permiso al dispositivo
  var status = await Permission.storage.status;

  print(status);
  //Si es denegado, solicitarlo
  if (!status.isGranted) {
    await Permission.storage.request();
  }

  List<int>? bytes = excel.save(fileName: 'fichas.xlsx');

  //Obtener el directorio de descargas
  final Directory? dir = await getExternalStorageDirectory();

  //Guardar el archivo en el directorio
  //de descargas
  print(dir!.path);

  //Si no existe, crearlo
  final path = dir.path;
  if (!await Directory(path).exists()) {
    await Directory(path).create(recursive: true);
  }

  print('existe directorio');
  //Guardar el archivo
  File file = File('$path/fichas.xlsx');

  await file.writeAsBytes(bytes!);

  print(file.path);

  file.createSync(recursive: true);

  print(file.existsSync() ? 'guardado' : 'no guardado');

  //Abrir el archivo en el dispositivo
  //con la aplicacion por defecto
  OpenFile.open(file.path);
  return true;
}
