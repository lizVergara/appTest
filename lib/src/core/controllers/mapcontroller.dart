import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../features/driver_selection/data/models/driver.dart';
import '../../features/stores/logic/data/models/store.dart';

class MapController extends GetxController {
  final String _urlBase = '192.168.1.109:8000'; //ip local de la computadora

  final List<LatLng> _positions = [];

  //Set<Polyline> poly = {};
  Set<Marker> markers = {};
  RxString _detail = ''.obs;

  CameraPosition initialCameraPosition = const CameraPosition(
      zoom: 13, target: LatLng(-2.145504426144382, -79.86709830454936));

/***Getters */
  List<LatLng> get positions => _positions;
  Set<Marker> get getMarkers => markers;
  String get detail => _detail.value;

/**Setters**/
  void addPosition(LatLng newPosition) {
    _positions.add(newPosition);
  }

  void setDetail(String newValue) => _detail.value += newValue;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    _positions.add(const LatLng(-2.14550, -79.86709));
  }

  // void setMarkers(LatLng newPosition, String icon, String title) async {
  void setMarkers(dynamic data, String icon) async {
    String description = '';
    List<String> datos = [];
    if (data is Store) {
      data.orders?.forEach((order) {
        description += 'Orden: ${order.id} driver: ${order.driverId} \n';
        setDetail('Orden: ${order.id} de Store: ${data.name} asignada a  driver: ${order.driverId} \n \n');
      });
      
      print(description);
    }
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/$icon",
    );
    markers.add(
      Marker(
        markerId: MarkerId(LatLng(data.lat, data.lng).toString()),
        position: LatLng(data.lat, data.lng),
        icon: markerbitmap,
        infoWindow: InfoWindow(
          title: data.name,
          snippet: data is Store ? description : 'Driver ID: ${data.id}',
        ),
      ),
    );
  }

  void _agregarMarcador(double lat, double lng, String titulo) {
    var marker = Marker(
      markerId: MarkerId('$lat$lng'),
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(
        title: titulo,
      ),
    );
    markers.add(marker);
  }

}
