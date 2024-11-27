import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;

  final LatLng _initialPosition = LatLng(48.8566, 2.3522); // Paris
  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId("marker_1"),
      position: LatLng(48.8566, 2.3522),
      infoWindow: InfoWindow(title: "Paris", snippet: "Capitale de la France"),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carte Flutter')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 12.0,
        ),
        markers: _markers,
        onMapCreated: (controller) {
          _controller = controller;
        },
      ),
    );
  }
}
