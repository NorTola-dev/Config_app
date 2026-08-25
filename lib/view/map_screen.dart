import 'dart:async';

import 'package:configapp/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(11.5564, 104.9282),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              DateTime? date = await showDatePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
                initialDate: DateTime.now(),
              );

              if (date == null) return;

              TimeOfDay? selectTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (selectTime == null) return;

              DateTime? datetime = DateTime(
                date.year,
                date.month,
                date.day,
                selectTime.hour,
                selectTime.minute,
              );

              print("Selected: $datetime");

              await NotificationController.showNotificationSchedule(datetime);
            },
            icon: Icon(Icons.notification_important_sharp),
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(11.5564, 104.9282),
          zoom: 15,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
