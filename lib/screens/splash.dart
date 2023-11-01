//Splashscreen que muestra la imagen del ips
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:registro_pacientes/screens/tabs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.segundos,
  });

  final int segundos;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Abrir la pantalla de tabs tras unos segundos
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: widget.segundos),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const TabsScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset(
        'assets/img/IPSlogo.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
