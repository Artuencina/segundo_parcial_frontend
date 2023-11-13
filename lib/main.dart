import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registro_pacientes/screens/splash.dart';

//Definicion de temas
final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: GoogleFonts.latoTextTheme(),
);

//Tema oscuro
final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blueGrey,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: Colors.black,
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  //Ensure initialized
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: const SplashScreen(segundos: 2),
    ),
  ));
}
