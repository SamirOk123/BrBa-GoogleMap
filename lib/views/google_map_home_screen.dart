import 'dart:async';
import 'package:breaking_bad/controllers/google_map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapHomeScreen extends StatelessWidget {
  GoogleMapHomeScreen({Key? key}) : super(key: key);

  final Completer<GoogleMapController> _controller = Completer();

  //CHANGED MAP CENTER TO DOMLUR LOCATION
  static CameraPosition kDomlur =
      const CameraPosition(target: LatLng(12.9610, 77.6387), zoom: 14.4746);

//DEPENDENCY INJECTION
  final googleMapController = Get.put(GoogleMapGetxController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: kDomlur,
          markers: Set<Marker>.of(googleMapController.marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
