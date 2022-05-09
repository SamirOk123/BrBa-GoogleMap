import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapHomeScreen extends StatefulWidget {
  const GoogleMapHomeScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapHomeScreen> createState() => _GoogleMapHomeScreenState();
}

class _GoogleMapHomeScreenState extends State<GoogleMapHomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  //CHANGED MAP CENTER TO DOMLUR LOCATION
  static CameraPosition kDomlur =
      const CameraPosition(target: LatLng(12.9610, 77.6387), zoom: 14.4746);

  List<Marker> _marker = [];
  List<Marker> _list = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(12.9610, 77.6387),
      infoWindow: InfoWindow(title: 'DOMLUR'),
    ),
  ];

  @override
  void initState() {
   _marker.addAll(_list);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: kDomlur,markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
