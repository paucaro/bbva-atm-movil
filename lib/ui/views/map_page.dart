import 'dart:async';

import 'package:custom_bottom_sheet/custom_bottom_sheet.dart';
import 'package:dashrock/api_client/network/entity/atm_entity.dart';
import 'package:dashrock/api_client/network/entity/atm_request.dart';
import 'package:dashrock/bloc/atm/atm_bloc.dart';
import 'package:dashrock/constants/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late LatLng currentLatLng = const LatLng(16.754186, -93.130481);
  final Completer<GoogleMapController> _controller = Completer();

  Future<void> _determinePosition() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentLatLng = LatLng(position.latitude, position.longitude);
    });
    return;
  }

  Set<Marker> _getMarkers(List<AtmEntity> atms) {
    Set<Marker> markers = {
      Marker(
        draggable: true,
        markerId: const MarkerId("0"),
        position: currentLatLng,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: 'Mi ubicacion',
        ),
      ),
    };
    for (var atm in atms) {
      markers.add(
        Marker(
          draggable: false,
          markerId: MarkerId(atm.atmId),
          position: LatLng(atm.latitud, atm.longitud),
          icon: BitmapDescriptor.defaultMarkerWithHue(atm.status
              ? BitmapDescriptor.hueGreen
              : BitmapDescriptor.hueOrange),
          infoWindow: InfoWindow(
              title: atm.calle, snippet: '${atm.colonia}, ${atm.estado}'),
          onTap: () {
            customBottomSheet(context, atm);
          },
        ),
      );
      print(atm.toJson());
    }

    return markers;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AtmBloc, AtmState>(
      builder: (context, state) {
        switch (state.status) {
          case AtmStatus.failure:
            return const Center(child: Text('Failed'));
          case AtmStatus.success:
            return Scaffold(
              body: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition:
                    CameraPosition(target: currentLatLng, zoom: 30),
                onMapCreated: (controller) {
                  _controller.complete(controller);
                },
                markers: _getMarkers(state.atms),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: _goToCurrentLocation,
                child: const Icon(Icons.location_searching),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniStartFloat,
            );
          case AtmStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void customBottomSheet(BuildContext context, AtmEntity atm) {
    SlideDialog.showSlideDialog(
      context: context,
      backgroundColor: Colors.white,
      pillColor: Colors.orange,
      transitionDuration: const Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(atm.status
                            ? 'assets/images/good.jpg'
                            : 'assets/images/crash.jpg'),
                        fit: BoxFit.fill),
                  ),
                ),
                Expanded(
                  child: Text(
                    atm.status ? 'Funciona!' : 'Tiene fallas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: atm.status ? Colors.green : Colors.orange),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  getRowData('Sitio', atm.sitio),
                  getRowData('Calle', atm.calle),
                  getRowData('Ciudad', atm.ciudad),
                  getRowData('Colonia', atm.colonia),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getRowData(String label, String texto) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.orange,
                  border: Border.all(color: Colors.orange),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(label,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ),
          ),
          Text(texto)
        ],
      ),
    );
  }

  Future<void> _goToCurrentLocation() async {
    EasyLoading.show(status: 'loading...');
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    await _determinePosition();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: currentLatLng, zoom: 10),
    ));
    context.read<AtmBloc>().add(AtmFetched(
        request: AtmRequest(
            currentLatLng.latitude, currentLatLng.longitude, fecha, radio)));

    EasyLoading.dismiss();
  }
}
