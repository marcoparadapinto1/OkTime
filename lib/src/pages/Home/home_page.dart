import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/pages/Home/home_controller.dart';
import 'dart:async';


class HomePage extends StatelessWidget {
  HomeController con = Get.put(HomeController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment:MainAxisAlignment.center,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Ramos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Recordatorios',),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Cerrar Sesión',
          ),
        ],
        currentIndex: 0, // Índice del elemento seleccionado inicialmente
        onTap: (index) {
          // Acción a realizar cuando se toca un elemento
          switch (index) {
            case 0:
            // Navegar a la página de Ramos
              Get.toNamed('/subject');
              break;
            case 1:
            // Navegar a la página de Recordatorios
              Get.toNamed('/reminders');
              break;
            case 2:
            // Navegar a la página de Calendario
              Get.toNamed('/calendar');
              break;
            case 3:
            // Cerrar sesión
              con.singOut();
              break;
          }
        },
      ),
    );
  }
}