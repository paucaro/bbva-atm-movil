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

import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();
const kGoogleApiKey = "AIzaSyCX5yBC59K87Mn7M9R9kULdYKxGvl7ppJw";

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late LatLng currentLatLng = const LatLng(16.7604127, -93.1527846);
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
          markerId: MarkerId('${atm.latitud}${atm.longitud}'),
          position: LatLng(atm.latitud, atm.longitud),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              getHueIdentify(atm.totalAtms, atm.totalAtmsFalla)),
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

  double getHueIdentify(int total, int fallas) {
    if (total == fallas) {
      return BitmapDescriptor.hueOrange;
    } else if (total - fallas >= (total / 2).round()) {
      return BitmapDescriptor.hueYellow;
    } else {
      return BitmapDescriptor.hueGreen;
    }
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
              appBar: AppBar(
                centerTitle: true,
                toolbarHeight: 70,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                elevation: 10,
                title: const Text("DashRock"),
                actions: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: _handlePressButton,
                        child: Icon(
                          Icons.search,
                          size: 26.0,
                        ),
                      )),
                ],
              ),
              body: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition:
                    CameraPosition(target: currentLatLng, zoom: 14),
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
                        image: AssetImage((atm.totalAtms - atm.totalAtmsFalla >=
                                (atm.totalAtms / 2).round())
                            ? 'assets/images/crash.jpg'
                            : 'assets/images/good.jpg'),
                        fit: BoxFit.fill),
                  ),
                ),
                Expanded(
                  child: Center(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Text(
                                '${atm.totalAtms - atm.totalAtmsFalla} de ${atm.totalAtms}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 16),
                              ),
                              Text('ATM'),
                              Text('operativos'),
                            ],
                          ),
                          padding: const EdgeInsets.all(12),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(12))),
                          child: Text(
                            getDescriptionEstado(
                                atm.totalAtms, atm.totalAtmsFalla),
                            style: TextStyle(color: Colors.white),
                          ),
                          padding: const EdgeInsets.all(12),
                        )
                      ],
                    ),
                  )),
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

  String getDescriptionEstado(int total, int fallas) {
    if (total == fallas) {
      return 'No operativo';
    } else if (total - fallas >= (total / 2).round()) {
      return 'Parcialmente operativo';
    } else {
      return 'Operativo';
    }
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

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMessage!)),
    );
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: Mode.overlay,
      language: "es",
      decoration: InputDecoration(
        hintText: 'Buscar',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "es")],
    );

    displayPrediction(p, context);
  }
}

Future<void> displayPrediction(Prediction? p, BuildContext context) async {
  if (p != null) {
    // get detail (lat/lng)
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${p.description} - $lat/$lng")),
    );
  }
}
