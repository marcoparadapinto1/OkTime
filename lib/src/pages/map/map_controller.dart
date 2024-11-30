import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';


class MapController extends GetxController {
  CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(-33.5095152, -70.757588), // Posición inicial por defecto
    zoom: 14.4746,
  );
  Set<Circle> circles = {};
  StreamSubscription<Position>? _positionStreamSubscription;
  bool _initialLocationSet = false;
  void startLocationTracking() {
    _positionStreamSubscription = Geolocator.getPositionStream().listen((Position position) {
      _currentPosition = position;
      // Actualiza la posición del marcador del usuario
      userMarker =Marker(
        markerId: MarkerId('userLocation'),
        position: LatLng(position.latitude, position.longitude),
      );
      // Actualiza la vista del mapa solo si la ubicación inicial no se ha establecido
      if (!_initialLocationSet) {
        googleMapController?.animateCamera(CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
        _initialLocationSet = true; // Marca la ubicación inicial como establecida
      }
      update();
    });
  }
  LatLng? selectedLocation;
  Marker? userMarker;
  void updateSelectedLocation(LatLng location, {bool isSaving = false}) async{
    selectedLocation = location;if (isSaving) {
      savedLocation = location;
      // Agrega el nuevo Circle al Set<Circle> existente
      circles.add(
        Circle(
          circleId: CircleId('perimeter'),
          center: location,
          radius: 500, // Radio en metros
          strokeColor: Colors.red,
          strokeWidth: 2,
          fillColor: Colors.red.withOpacity(0.2),
        ),
      );
      await scheduleAlarm(location); // Llama a scheduleAlarm desde aquí

    }
    update();
  }
  GoogleMapController? googleMapController;
  Position? _currentPosition; // Variable para almacenar la ubicación actual
  Set<Marker> markers = {}; // Set para almacenar los marcadores
  LatLng? savedLocation;

  void onMapCreated(GoogleMapController mapController) {
    googleMapController = mapController;
  }
  @override
  void onInit() {
    super.onInit();
    _getCurrentPosition().then((_) {
      // Después de obtener la ubicación actual, agrega un marcador inicial
      if (_currentPosition != null) {
        updateSelectedLocation(LatLng(_currentPosition!.latitude, _currentPosition!.longitude));
      }
      startLocationTracking();
      Timer.periodic(Duration(seconds: 5), (timer) {
        checkLocation();
      });
    });}

  Future<void> _getCurrentPosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Comprueba si los servicios de ubicación están habilitados.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Los servicios de ubicación no están habilitados.
        return Future.error('Los servicios de ubicación están deshabilitados.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Se denegó el permiso de ubicación.
          return Future.error('Se denegó el permiso de ubicación.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Se denegó el permiso de ubicación permanentemente.
        return Future.error(
            'El permiso de ubicación se denegó permanentemente, no podemos solicitar permisos.');
      }

      // Cuando llegamos aquí, los permisos están otorgados y podemos
      // continuar accediendo a la posición del dispositivo.
      _currentPosition = await Geolocator.getCurrentPosition();

      // Actualiza la posición inicial de la cámara
      initialCameraPosition = CameraPosition(
        target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        zoom: 14.4746,
      );

      // Agrega un marcador en la ubicación actual
      markers.add(
        Marker(
          markerId: MarkerId('currentLocation'),
          position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          infoWindow: InfoWindow(title: 'Mi ubicación'),
        ),
      );

      update(); // Actualiza la vista para mostrar el marcador y mover la cámara
    } catch (e) {
      // Maneja errores en la inicialización del mapa
      Get.snackbar('Error', 'No se pudo inicializar el mapa.');
    }
  }
  void _alarmCallback() {
    // Lógica que se ejecutará cuando se active la alarma
    // Por ejemplo, mostrar una notificación o realizar alguna acción
    print('Alarma activada!');
  }
  @override
  void onClose() {
    _positionStreamSubscription?.cancel();
    super.onClose();
  }
  void checkLocation() async {
    Position currentPosition = await Geolocator.getCurrentPosition(); // Obtén la ubicación actual
    double distance = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      selectedLocation!.latitude,
      selectedLocation!.longitude,
    );if (distance <= 300) { // Verifica si la distancia es menor o igual a 500 metros
      print('El usuario está en el punto seleccionado');
      Get.snackbar(
        'Soy una alarma',
        'Has llegado a tu destino, despierta!',
        duration: Duration(seconds: 5), // Duración del GetBar
      );
    } else {
      print('El usuario NO está en el punto seleccionado'); // Agrega un mensaje para cuando no esté en el punto
    }
  }
  Future<void> scheduleAlarm(LatLng location) async {
    // Lógica para programar la alarma utilizando la ubicación
    // Puedes usar la librería android_alarm_manager_plus o cualquier otra librería de tu preferencia
    // Ejemplo con android_alarm_manager_plus:

    // Define un ID único para la alarma
    const int alarmId = 1;

    // Define la hora a la que se activará la alarma (por ejemplo, en 5 minutos)
    final DateTime alarmTime = DateTime.now().add(Duration(minutes: 5));

    // Programa la alarma
    await AndroidAlarmManager.oneShotAt(
      alarmTime,
      alarmId,
      _alarmCallback, // Función que se ejecutará cuando se active la alarma
      exact: true,
      wakeup: true,
    );
  }

}
