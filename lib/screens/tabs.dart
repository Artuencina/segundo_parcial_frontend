import 'package:flutter/material.dart';
import 'package:registro_pacientes/screens/categorias.dart';
import 'package:registro_pacientes/screens/fichas.dart';
import 'package:registro_pacientes/screens/personas.dart';
import 'package:registro_pacientes/screens/reservas.dart';

final colores = [
  Colors.green,
  Colors.amber.shade700,
  Colors.blue,
  Colors.purple,
  Colors.red
];

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  //Lista de pantallas
  //En teoria esto se puede hacer con route y eso
  //pero todavia no se como

  final List<Widget> screens = [
    CategoriasScreen(
      color: colores[0],
    ),
    PersonasScreen(
      mainColor: colores[1],
      esDoctor: false,
    ),
    PersonasScreen(
      mainColor: colores[2],
      esDoctor: true,
    ),
    ReservasScreen(
      color: colores[3],
    ),
    FichasScreen(
      mainColor: colores[4],
    )
  ];

  //Widget principal que se muestra en pantalla
  int activeIndex = 0;
  Widget? activeScreen;

  @override
  void initState() {
    activeScreen = screens[0];
    super.initState();
  }

  //Metodo para cambiar de pantalla
  void changeScreen(int index) {
    //Cambiar el estado de la pantalla al tab seleccionado
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Cambiar activescreen segun el index
    activeScreen = screens[activeIndex];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white60,
        type: BottomNavigationBarType.shifting,
        currentIndex: activeIndex,
        onTap: (value) => (changeScreen(value)),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.category),
            label: "Categorias",
            backgroundColor: colores[0],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "Pacientes",
            backgroundColor: colores[1],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.medical_services),
            label: "Doctores",
            backgroundColor: colores[2],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today),
            label: "Reservas",
            backgroundColor: colores[3],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.article),
            label: "Fichas",
            backgroundColor: colores[4],
          ),
        ],
      ),
      body: activeScreen,
    );
  }
}
