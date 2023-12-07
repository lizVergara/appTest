import 'dart:convert';

import 'package:driver_app/src/features/driver_selection/data/models/driver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../core/controllers/mapcontroller.dart';

class DriverProvider extends ChangeNotifier {
  final String _urlBase = '192.168.1.109:8000'; //ip local de la computadora

  List<Driver> drivers = [];
  bool loading = false;
  Driver? driver;
  MapController mapController = Get.put(MapController());

  DriverProvider() {
    print("Inicializado");
    getDrivers();
  }

  getDrivers() async {
    print("Inicializado");

    loading = true;
    var url = Uri.http(_urlBase, '/api/drivers');
    final response = await http.get(url);
    drivers = List<Driver>.from(
        json.decode(response.body).map((x) => Driver.fromMap(x)));
    loading = false;
    for (var driver in drivers) {
      mapController.setMarkers(driver, "deliver.png");
    }

    notifyListeners();
  }

  setDriver(Driver driver) {
    this.driver = driver;
    notifyListeners();
  }
}
