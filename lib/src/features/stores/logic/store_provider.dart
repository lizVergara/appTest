import 'dart:convert';

import 'package:driver_app/src/features/driver_selection/data/models/driver.dart';
import 'package:driver_app/src/features/stores/logic/data/models/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../core/controllers/mapcontroller.dart';

class StoreProvider extends ChangeNotifier {
  final String _urlBase = '192.168.1.109:8000'; //ip local de la computadora

  List<Store> stores = [];
  bool loading = true;
  Store? store;
  MapController mapController = Get.put(MapController());

  StoreProvider() {
    print("Inicializado store");
    getStores();
  }
  

  getStores() async {
    print("Inicializado store");

    loading = true;
    var url = Uri.http(_urlBase, '/api/stores');
    final response = await http.get(url);
    stores = List<Store>.from(
        json.decode(response.body).map((x) => Store.fromMap(x)));
    loading = false;
    for (var store in stores) {
          mapController.setMarkers(store, "image.png");
    }

    notifyListeners();
  }

  setDriver(Store store) {
    this.store = store;
    notifyListeners();
  }
}
