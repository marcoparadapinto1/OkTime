import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:udemy_flutter_delivery/src/pages/map/map_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';


class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      init: MapController(),
      builder: (controller) {
        return Scaffold(
          body: Stack( // Usa un Stack para superponer la barra sobre el mapa
            children: [
              GoogleMap(
                initialCameraPosition: controller.initialCameraPosition,
                onMapCreated: (GoogleMapController mapController) {
                  controller.onMapCreated(mapController);
                },
                onTap: (location) {
                  controller.updateSelectedLocation(location);
                },
                markers: {
                  if (controller.selectedLocation != null)
                    Marker(
                      markerId: const MarkerId('selectedLocation'),
                      position: controller.selectedLocation!,
                    ),
                  if (controller.userMarker != null) controller.userMarker!,
                },
                circles: controller.circles,
              ),
              // Barra con botones
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back(); // Acción para el botón "Atrás"
                        },
                        child: Text('Atrás'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (controller.selectedLocation != null) {
                            // Guarda la ubicación seleccionada
                            controller.updateSelectedLocation(controller.selectedLocation!, isSaving: true);
                            // Ya no necesitas llamar a scheduleAlarm aquí

                            Get.back(result: controller.selectedLocation);
                          }
                        },
                        child: Text('Seleccionar'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
