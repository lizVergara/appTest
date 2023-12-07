import 'dart:async';

import 'package:driver_app/src/features/driver_selection/logic/driver_provider.dart';
import 'package:driver_app/src/features/stores/logic/store_provider.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_utils/google_maps_utils.dart';
import '../../../core/controllers/mapcontroller.dart';
import 'widgets/card_profile.dart';

class DriverSelectionScreen extends StatefulWidget {
  const DriverSelectionScreen({Key? key}) : super(key: key);

  @override
  State<DriverSelectionScreen> createState() => _DriverSelectionScreenState();
}

class _DriverSelectionScreenState extends State<DriverSelectionScreen> {
  // final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    MapController mapController = Get.put(MapController());
    final Completer<GoogleMapController> googleMapController = Completer();

    final driverProvider = Provider.of<DriverProvider>(context);
    final storeProvider = Provider.of<StoreProvider>(context);
     String text = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: (driverProvider.loading && storeProvider.loading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: GoogleMap(
                      markers: mapController.getMarkers,
                      mapType: MapType.normal,
                      initialCameraPosition:
                          mapController.initialCameraPosition,
                      onMapCreated: (GoogleMapController controller) {
                        googleMapController.complete(controller);
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Información de Pedidos"),
                            content: Text(
                                mapController.detail),
                            actions: [
                              TextButton(
                                onPressed: () {

                                  Navigator.of(context).pop();
                                },
                                child:  Text(
                                    ''),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Información de Pedidos"),
                  ),
                ],
              ),
            ),
    );
  }
}
