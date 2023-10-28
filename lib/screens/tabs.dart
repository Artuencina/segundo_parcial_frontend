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
  //pero no se como
  final List<Widget> screens = [
    CategoriasScreen(
      color: colores[0],
      categorias: const [],
    ),
    PersonasScreen(
      mainColor: colores[1],
      personas: const [],
      esDoctor: false,
    ),
    PersonasScreen(
      personas: const [],
      mainColor: colores[2],
      esDoctor: true,
    ),
    ReservasScreen(
      reservas: const [],
      color: colores[3],
    ),
    const FichasScreen(),
  ];

  //Widget principal que se muestra en pantalla
  int activeIndex = 0;
  Widget? activeScreen;
  Color? activeColor; //Y su color

  @override
  void initState() {
    activeScreen = screens[0];
    activeColor = colores[0];
    super.initState();
  }

  //Metodo para cambiar de pantalla
  void changeScreen(int index) {
    //Cambiar el estado de la pantalla al tab seleccionado
    setState(() {
      activeIndex = index;
      activeColor = colores[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    //Cambiar activescreen segun el index
    activeScreen = screens[activeIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de pacientes"),
        backgroundColor: activeColor,
        foregroundColor: Colors.white,
        actions: [
          //Boton de filtro que abre un modal de filtro segun la pantalla activa
          IconButton(
            onPressed: () {
              //Abrir modal de filtro
            },
            icon: const Icon(Icons.filter_alt),
          ),

          //Boton para exportar solo si es la ventana de fichas
          if (activeIndex == 4)
            IconButton(
              onPressed: () {
                //Exportar fichas
              },
              icon: const Icon(Icons.exit_to_app),
            ),
        ],
      ),
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
