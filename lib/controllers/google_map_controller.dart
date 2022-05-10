import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapGetxController extends GetxController {
  final List<Marker> marker = [];
  final List<Marker> list = [
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(12.9610, 77.6387),
      infoWindow: InfoWindow(title: 'Domlur'),
    ),
    const Marker(
      markerId: MarkerId('2'),
      position: LatLng(12.962938, 77.632852),
      infoWindow: InfoWindow(title: 'Domlur Village'),
    ),
    const Marker(
      markerId: MarkerId('3'),
      position: LatLng(12.968165, 77.631801),
      infoWindow: InfoWindow(title: 'Domlur Village'),
    ),
    const Marker(
      markerId: MarkerId('4'),
      position: LatLng(12.964897, 77.633897),
      infoWindow: InfoWindow(title: 'BDA Colony'),
    ),
    const Marker(
      markerId: MarkerId('5'),
      position: LatLng(12.966897, 77.633897),
      infoWindow: InfoWindow(title: 'Defence Colony'),
    ),
  ];

//ADDING ALL MARKERS TO THE MARKER LIST
  @override
  void onInit() {
    marker.addAll(list);
    super.onInit();
  }
}
